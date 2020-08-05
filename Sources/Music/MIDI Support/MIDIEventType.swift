//
//  MIDIMetaEvent.swift
//  Music
//
//  Created by Mike Muszynski on 1/4/18.
//  Copyright © 2018 Mike Muszynski. All rights reserved.
//

import Foundation

enum MIDIEventType {
    case noteOff(key: UInt8, velocity: UInt8)
    case noteOn(key: UInt8, velocity: UInt8)
    case polyphonicKeyPressure(key: UInt8, pressure: UInt8)
    case controllerChange(number: UInt8, value: UInt8)
    case programChange(newProgramNumber: UInt8)
    case channelKeyPressure(pressure: UInt8)
    case pitchBend(mostSignificantByte: UInt8, leastSignificantByte: UInt8)
    
    init(from data: Data, at offset: inout Int, statusByte: UInt8) throws {
        switch statusByte {
        case 0x80...0x8F:
            //two data bytes
            let releasedKey = data[offset].bigEndian
            let velocity = data[offset+1].bigEndian
            offset += 2
            self = .noteOff(key: releasedKey, velocity: velocity)
        case 0x90...0x9F:
            let pressedKey = data[offset].bigEndian
            let velocity = data[offset+1].bigEndian
            offset += 2

            if velocity == 0 {
                self = .noteOff(key: pressedKey, velocity: 0x40)
            } else {
                self = .noteOn(key: pressedKey, velocity: velocity)
            }
        case 0xA0...0xAF:
            let pressedKey = data[offset].bigEndian
            let pressure = data[offset+1].bigEndian
            offset += 2
            
            self = .polyphonicKeyPressure(key: pressedKey, pressure: pressure)
        case 0xB0...0xBF:
            let number = data[offset].bigEndian
            let value = data[offset+1].bigEndian
            offset += 2
            
            self = .controllerChange(number: number, value: value)
        case 0xC0...0xCF:
            let newValue = data[offset].bigEndian
            offset += 1
            
            self = .programChange(newProgramNumber: newValue)
        case 0xD0...0xDF:
            let newValue = data[offset].bigEndian
            offset += 1
            
            self = .channelKeyPressure(pressure: newValue)
        case 0xE0...0xEF:
            let most = data[offset].bigEndian
            let least = data[offset+1].bigEndian

            self = .pitchBend(mostSignificantByte: most, leastSignificantByte: least)
        default:
            throw MIDIDecodeError.unsupportedEventType
        }        
    }
}

/// MIDI specifies a number of Meta Events that are not commands but rather metadata information
///
enum MIDIMetaEventType {
    ///Sequence Number
    ///
    /// This is an optional event, which must occur only at the start of a track, before any non-zero delta-time.
    /// For Format 2 MIDI files, this is used to identify each track. If omitted, the sequences are numbered sequentially in the order the tracks appear.
    /// For Format 1 files, this event should occur on the first track only.
    case sequenceNumber(_: Int16)
    
    /// Text Event
    ///
    /// This event is used for annotating the track with arbitrary text.
    /// Arbitrary 8-bit data (other than ascii text) is also permitted.
    case dataEvent(data: Data)
    case textEvent(text: String)
    
    /// This event is for a Copyright notice in ascii text.
    /// This should be of the form "(C) 1850 J.Strauss"
    /// This event should be the first event on the first track.
    case copyrightNotice(_: String)
    
    /// Name of the sequence or track
    case trackName(_: String)
    
    /// A description of the instrument(s) used on this track.
    /// This can also be used to describe instruments on a particular MIDI Channel within a track, by preceding this event with the meta-event MIDI Channel Prefix. (or specifying the channel(s) within the text).
    case intstrumentName(_: String)
    
    /// Lyrics for the song.
    /// Normally, each syllable will have it's own lyric-event, which occurs at the time the lyric is to be sung.
    case songLyric(_: String)
    
    /// Normally on the first track of a format 1 or format 0 file.
    /// Marks a significant point in the sequence (eg "Verse 1")
    case marker(_: String)
    
    /// Used to include cues for events happening on-stage, such as "curtain rises", "exit, stage left", etc.
    case cuePoint(_: String)
    
    /// Associate all following meta-events and sysex-events with the specified MIDI channel, until the next <midi_event> (which must contain MIDI channel information).
    case channelPrefix(_: UInt8)
    
    /// This event is not optional.
    /// It is used to give the track a clearly defined length, which is essential information if the track is looped or concatenated with another track.
    case endOfTrack
    
    /// This sets the tempo in microseconds per quarter note. This means a change in the unit-length of a delta-time tick. (note 1)
    /// If not specified, the default tempo is 120 beats/minute, which is equivalent to tttttt=500000
    case setTempo(microseconds: Int32)
    
    /// This (optional) event specifies the SMTPE time at which the track is to start.
    /// This event must occur before any non-zero delta-times, and before any MIDI events.
    /// In a format 1 MIDI file, this event must be on the first track (the tempo map).
    /// hh mm ss fr    hours/minutes/seconds/frames in SMTPE format
    ///  this must be consistant with the message MIDI Time Code Quarter Frame (in a particular, the time-code type must be present in hh)
    /// ff    Fractional frame, in hundreth's of a frame
    case smtpeOffset(hours: UInt8, minutes: UInt8, seconds: UInt8, frames: UInt8, fractionalFrames: UInt8)

    ///    FF 58 04 nn dd cc bb    Time Signature
    ///    Time signature of the form:
    ///    nn/2^dd
    ///    eg: 6/8 would be specified using nn=6, dd=3
    ///    The parameter cc is the number of MIDI Clocks per metronome tick.
    ///
    ///    Normally, there are 24 MIDI Clocks per quarter note. However, some software allows this to be set by the user. The parameter bb defines this in terms of the number of 1/32 notes which make up the usual 24 MIDI Clocks (the 'standard' quarter note).
    ///
    ///    nn    Time signature, numerator
    ///    dd    Time signature, denominator expressed as a power of 2.
    ///    eg a denominator of 4 is expressed as dd=2
    ///    cc    MIDI Clocks per metronome tick
    ///    bb    Number of 1/32 notes per 24 MIDI clocks (8 is standard)
    case timeSignature(numerator: UInt8, denominator: UInt8, clocksPerTick: UInt8, thirtysecondsPerClock: UInt8)
 
//    FF 59 02 sf mi    Key Signature
//    Key Signature, expressed as the number of sharps or flats, and a major/minor flag.
//    0 represents a key of C, negative numbers represent 'flats', while positive numbers represent 'sharps'.
//
//    sf    number of sharps or flats
//    -7 = 7 flats
//    0 = key of C
//    +7 = 7 sharps
//    mi    0 = major key
//    1 = minor key
    case keySignature(sharpsOrFlats: UInt8, major: Bool)

//    FF 7F <len> <id> <data>    Sequencer-Specific Meta-event
//    This is the MIDI-file equivalent of the System Exclusive Message.
//    A manufacturer may incorporate sequencer-specific directives into a MIDI file using this event.
//
//    <len>    length of <id>+<data> (variable length quantity)
//    <id>    1 or 3 bytes representing the Manufacturer's ID
//    This value is the same as is used for MIDI System Exclusive messages
//    <data>    8-bit binary data
//    case sequencerEvent()
    
    init(from data: Data, at offset: inout Int) throws {
        //meta event starts with a status byte, followed by a length byte
        //the is sometimes small and sometimes variable length
        //can probably be treated as only variable length
        let statusByte = data[offset].bigEndian
        offset += 1
        
        let eventDataLength = getVariableLength(from: data, at: &offset)
        let eventData = Data(data[offset..<offset+eventDataLength])
        offset += eventDataLength
        
        //cool, now that's all taken care of, we need to check all the different meta types and deal with the data
        switch statusByte {
        case 0x00:
            //sequence number
            let number = try eventData.decode(Int16.self)
            self = MIDIMetaEventType.sequenceNumber(number)
        case 0x01:
            //text event
            let text = try eventData.decodeString(encoding: .ascii)
            self = MIDIMetaEventType.textEvent(text: text)
        case 0x02:
            let text = try eventData.decodeString(encoding: .ascii)
            self = MIDIMetaEventType.copyrightNotice(text)
        case 0x03:
            let text = try eventData.decodeString(encoding: .ascii)
            self = MIDIMetaEventType.trackName(text)
        case 0x04:
            let text = try eventData.decodeString(encoding: .ascii)
            self = MIDIMetaEventType.intstrumentName(text)
        case 0x05:
            let text = try eventData.decodeString(encoding: .ascii)
            self = MIDIMetaEventType.songLyric(text)
        case 0x06:
            let text = try eventData.decodeString(encoding: .ascii)
            self = MIDIMetaEventType.marker(text)
        case 0x07:
            let text = try eventData.decodeString(encoding: .ascii)
            self = MIDIMetaEventType.cuePoint(text)
        case 0x20:
            self = MIDIMetaEventType.channelPrefix(eventData[0].bigEndian)
        case 0x2F:
            self = MIDIMetaEventType.endOfTrack
        case 0x51:
            //need to make an int32 out of 24 bits of data
            var intData = Data(repeatElement(0, count: 4))
            intData[1..<4] = eventData
            let microseconds = try intData.decode(Int32.self).bigEndian
            self = MIDIMetaEventType.setTempo(microseconds: microseconds)
        case 0x54:
            self = MIDIMetaEventType.smtpeOffset(hours: eventData[0].bigEndian,
                                                 minutes: eventData[1].bigEndian,
                                                 seconds: eventData[2].bigEndian,
                                                 frames: eventData[3].bigEndian,
                                                 fractionalFrames: eventData[4].bigEndian)
        case 0x58:
            self = MIDIMetaEventType.timeSignature(numerator: eventData[0].bigEndian,
                                                   denominator: eventData[1].bigEndian,
                                                   clocksPerTick: eventData[2].bigEndian,
                                                   thirtysecondsPerClock: eventData[3].bigEndian)
        case 0x59:
            self = MIDIMetaEventType.keySignature(sharpsOrFlats: eventData[0].bigEndian,
                                                  major: eventData[1].bigEndian == 0)
        default:
            throw MIDIDecodeError.unsupportedMetaEventType
        }
        
    }
}
/*



 */
