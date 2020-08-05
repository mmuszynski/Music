//
//  BasicMIDITests.swift
//  MusicTests
//
//  Created by Mike Muszynski on 8/5/20.
//  Copyright © 2020 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import Music

class BasicMIDITests: XCTestCase {

    // Tests both the MIDI values and an initializer for `MusicPitch` from a MIDI value
    func testMIDIValues() {
        XCTAssertEqual(MusicPitch(name: .c, accidental: .natural, octave: 4).midiKey, 60)
        XCTAssertEqual(MusicPitch(name: .b, accidental: .sharp, octave: 3).midiKey, 60)
        XCTAssertEqual(MusicPitch(name: .d, accidental: .doubleFlat, octave: 4).midiKey, 60)
        XCTAssertEqual(MusicPitch(name: .c, accidental: .natural, octave: -1).midiKey, 0)
        
        //C4 = 60
        //C3 = 48
        //B#3 = 60
        //F9 = 125
        XCTAssertEqual(MusicPitch(midiKey: 60, accidental: .natural), MusicPitch(name: .c, accidental: .natural, octave: 4))
        XCTAssertEqual(MusicPitch(midiKey: 48, accidental: .natural), MusicPitch(name: .c, accidental: .natural, octave: 3))
        XCTAssertEqual(MusicPitch(midiKey: 60, accidental: .sharp), MusicPitch(name: .b, accidental: .sharp, octave: 3))
        XCTAssertEqual(MusicPitch(midiKey: 125, accidental: .natural), MusicPitch(name: .f, accidental: .natural, octave: 9))
        
        //F4 spelled with a flat is impossible
        XCTAssertEqual(MusicPitch(midiKey: 65, accidental: .flat), nil)
    }
}
