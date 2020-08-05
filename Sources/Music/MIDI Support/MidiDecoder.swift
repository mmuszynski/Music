//
//  MidiDecoder.swift
//  Music
//
//  Created by Mike Muszynski on 1/3/18.
//  Copyright © 2018 Mike Muszynski. All rights reserved.
//

import Foundation

enum MIDIDecodeError: Error {
    case couldNotDecodeMIDIHeader
    case errorUnpackingValue
    case invalidMIDIFormat
    case unimplemented
    case unsupportedEventType
    case unsupportedMetaEventType
}

open class MidiDecoder: Decoder {
    public var codingPath: [CodingKey] = []
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        throw NSError()
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw NSError()
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        throw NSError()
    }
    
    open func decode(_ data: Data) throws -> Any {
        var offset: Int32 = 0
        let header = try _MIDIHeader(data: data)
        offset += header.length + 8

        var tracks = [_MIDITrack]()
        
        for _ in 0..<header.tracks {
            let track = try _MIDITrack(data: Data(data[offset...]))
            offset += track.length + 8
            tracks.append(track)
        }
        
        var trackNotes = [MusicPitch]()
        //get the notes from each track?
        for track in tracks {
            var notesCurrentlyOn = [MusicPitch]()
            let trackEvents = track.events.filter { $0 is _MIDIEvent } as! [_MIDIEvent]
            for event in trackEvents {
                switch event.eventType {
                    
                case .noteOff(let key, _):
                    let note = MusicPitch(midiKey: key)
                    trackNotes.append(note)
                case .noteOn(let key, _):
                    let note = MusicPitch(midiKey: key)
                    notesCurrentlyOn.append(note)
                default:
                    break
                }
            }
        }

        
        throw MIDIDecodeError.unimplemented
    }
    
}

enum MIDIFormat: Int16   {
    case singleTrack = 0, multiTrackSimultaneous, multitrackSequential
}

enum MIDITiming {
    case quarter(division: Int16)
}

fileprivate class _MIDIChunk {
    var type: String
    var length: Int32
    fileprivate var offset = 8
    
    init(data: Data) throws {
        //First four bytes is an ASCII String with the type of chunk
        let typeData = data[0..<4]
        guard let typeString = String(bytes: typeData, encoding: .ascii) else {
            throw MIDIDecodeError.couldNotDecodeMIDIHeader
        }
        self.type = typeString
        
        //Next 32 bits (4 bytes) is the length of the header in big endian
        let lengthData = data[4..<8]
        let lengthInt = try lengthData.decode(Int32.self).bigEndian
        self.length = lengthInt
    }
}

fileprivate class _MIDIHeader: _MIDIChunk {
    var format: MIDIFormat
    var tracks: Int16
    var timing: MIDITiming
    
    override init(data: Data) throws {
        //The first 8 bytes are taken care of by the superclass at the end of the method.
        //Next 16 bits is the type of header in big endian, and only valid if 0, 1, or 2
        //These are packed into an enum
        let formatData = data[8..<10]
        let formatInt = try formatData.decode(Int16.self).bigEndian
        guard let midiFormat = MIDIFormat(rawValue: formatInt) else {
            throw MIDIDecodeError.invalidMIDIFormat
        }
        self.format = midiFormat
        
        //Next 16 bits is the number of tracks
        let trackData = data[10..<12]
        let trackInt = try trackData.decode(Int16.self).bigEndian
        self.tracks = trackInt
        
        //Next part is tricky.
        //Depends on two formats.
        let divisionData = data[12..<14]
        let divisionInt = try divisionData.decode(Int16.self).bigEndian
        
        //most significant bit is set?
        if (divisionInt & 1<<15) == 1<<15 {
            //if so, it's complicated
            throw MIDIDecodeError.unimplemented
        } else {
            //otherwise
            //zero out the 15th bit
            let bitmask: Int16 = ~(1<<15)
            let divisionValue = (divisionInt & bitmask).bigEndian
            self.timing = .quarter(division: divisionValue)
        }
        
        //The first 8 bytes are taken care of in the superclass
        try super.init(data: data)
    }
}

fileprivate class _MIDITrack: _MIDIChunk {
    var events = [_MIDIBaseEvent]()
    override init(data: Data) throws {
        try super.init(data: data)
        
        //The offset is 8 after initialization
        //Now the events must be parsed
        while offset < length {
            events.append(try self.parseEvent(from: data, at: &offset))
        }        
    }
    
    /// Sometimes a new event isn't explicitly enumerated (to save space)
    /// Save the last event status in case
    private var lastEventStatusByte: UInt8?
    
    /// Starting at the offset listed, try to construct a MIDI Event
    ///
    /// - Parameters:
    ///   - data: The track data
    ///   - offset: The current offset of the data. Will be mutated as the track is read.
    /// - Returns: A MIDI Event
    private func parseEvent(from data: Data, at offset: inout Int) throws -> _MIDIBaseEvent {
        //get deltaTime
        let deltaTime = getVariableLength(from: data, at: &offset)
        
        //get status, which is a single byte
        var statusByte = data[offset].bigEndian
        
        //if this is not a valid status byte, use the previous status byte
        if 0x8F...0xFF ~= statusByte {
            lastEventStatusByte = statusByte
            offset += 1
        } else {
            guard let lastStatusByte = lastEventStatusByte else {
                throw MIDIDecodeError.invalidMIDIFormat
            }
            statusByte = lastStatusByte
        }
        
        switch statusByte {
        case 0x80...0xEF:
            let channel = statusByte & 0x0F
            let eventType = try MIDIEventType(from: data[offset...], at: &offset, statusByte: statusByte)
            return _MIDIEvent(type: eventType, channel: channel, deltaTime: deltaTime, statusByte: statusByte)
        case 0xFF:
            let metaEventType = try MIDIMetaEventType(from: data[offset...], at: &offset)
            return _MIDIMetaEvent(metaType: metaEventType, deltaTime: deltaTime, statusByte: statusByte)
        default:
            throw MIDIDecodeError.unsupportedEventType
        }
            
//        case .noteOff(let channel),
//             .noteOn(let channel),
//             .polyphonicKeyPressure(let channel),
//             .controllerChange(let channel),
//             .pitchBend(let channel):
//            //all these have two bits of data
//            let eventData = data[offset..<offset+2]
//            offset += 2
//
//            return _MIDIEvent(type: eventType, channel: channel, deltaTime: deltaTime, length: 2, statusByte: statusByte)
//        case .programChange(let channel),
//             .channelKeyPressure(let channel):
//            //all these have one bit of data
//            let eventData = data[offset..<offset+1]
//            offset += 1
//
//            return _MIDIEvent(type: eventType, channel: channel, deltaTime: deltaTime, length: 1, statusByte: statusByte)

        throw MIDIDecodeError.unsupportedEventType
    }
}

public func getVariableLength(from data: Data, at offset: inout Int) -> Int {
    //get the variable length of the event
    //first grab all the bytes that don't start with a 1 in the most significant bit
    var lengthBytes = [UInt8]()
    var shouldContinue = true
    
    while shouldContinue {
        let testByte = data[offset]
        lengthBytes.append(testByte)
        offset += 1
        shouldContinue = (testByte & 0x80) == 0x80
    }
    
    return lengthValue(fromMidiVariableLength: lengthBytes)
}

fileprivate class _MIDIBaseEvent {
    var deltaTime: Int = 0
    var status: UInt8 = 0
    
    init(deltaTime: Int, statusByte status: UInt8) {
        self.deltaTime = deltaTime
        self.status = status
    }
}

fileprivate class _MIDIEvent: _MIDIBaseEvent {
    var eventType: MIDIEventType
    var channel: UInt8
    
    init(type: MIDIEventType, channel: UInt8, deltaTime: Int, statusByte status: UInt8) {
        self.channel = channel
        self.eventType = type
        super.init(deltaTime: deltaTime, statusByte: status)
    }
}

fileprivate class _MIDIMetaEvent: _MIDIBaseEvent {
    var metaType: MIDIMetaEventType
    init(metaType: MIDIMetaEventType, deltaTime: Int, statusByte status: UInt8) {
        self.metaType = metaType
        super.init(deltaTime: deltaTime, statusByte: status)
    }
}

public func lengthValue(fromMidiVariableLength array: [UInt8]) -> Int {
    let data = Data(array)
    return lengthValue(fromMidiVariableLength: data)
}

public func lengthValue(fromMidiVariableLength data: Data) -> Int {
    var result = 0
    let ints = data.map { UInt8($0) }
    for byte in ints {
        result <<= 7
        let continueByteSet = (byte & 0x80) == 0x80
        let dataBytes = Int(byte & (~0x80))
        result |= dataBytes
        
        if !continueByteSet {
            return result
        }
    }
    fatalError()
}
