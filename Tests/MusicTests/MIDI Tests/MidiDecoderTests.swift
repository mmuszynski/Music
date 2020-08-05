//
//  MidiDecoderTests.swift
//  MusicTests
//
//  Created by Mike Muszynski on 1/3/18.
//  Copyright © 2018 Mike Muszynski. All rights reserved.


import XCTest
@testable import Music

class MidiDecoderTests: XCTestCase {
    
    func testVariableLengthDecode() {
        //Test values for the midi variable length
        let nums: [Int:[UInt8]] = [0x00000000: [0x00],
                                   0x00000040: [0x40],
                                   0x0000007F: [0x7F],
                                   0x00000080: [0x81, 0x00],
                                   0x00000100: [0x82, 0x00], //this comes from me and not midi
                                   0x00002000: [0xC0, 0x00],
                                   0x00003FFF: [0xFF, 0x7F],
                                   0x00004000: [0x81, 0x80, 0x00],
                                   0x00100000: [0xC0, 0x80, 0x00],
                                   0x001FFFFF: [0xFF, 0xFF, 0x7F],
                                   0x00200000: [0x81, 0x80, 0x80, 0x00],
                                   0x08000000: [0xC0, 0x80, 0x80, 0x00],
                                   0x0FFFFFFF: [0xFF, 0xFF, 0xFF, 0x7F]]
        
        for key in nums.keys {
            let target = key
            let inputData = Data(bytes: nums[key]!)
            XCTAssertEqual(lengthValue(fromMidiVariableLength: inputData), target)
        }
    }
    
    func testDecoder() {
        //get file
        guard let url = Bundle(for: self.classForCoder).url(forResource: "MIDI_sample", withExtension: "mid") else {
            fatalError()
        }
        
        let midiData = try! Data(contentsOf: url)
        let decoder = MidiDecoder()
        
        do {
            try decoder.decode(midiData)
        } catch {
            XCTFail("\(error)")
        }
    }
}
