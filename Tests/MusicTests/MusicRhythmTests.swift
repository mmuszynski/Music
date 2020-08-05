//
//  MusicRhythmTests.swift
//  Music
//
//  Created by Mike Muszynski on 4/6/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import Music

class MusicRhythmTests: XCTestCase {
    
    func testMusicRhythms() {
        let duration64: Double = 1
        XCTAssertEqual(MusicRhythm.sixtyfourth.duration, duration64)
        let duration32: Double = 2
        XCTAssertEqual(MusicRhythm.thirtysecond.duration, duration32)
        let duration16: Double = 4
        XCTAssertEqual(MusicRhythm.sixteenth.duration, duration16)
        let duration8: Double = 8
        XCTAssertEqual(MusicRhythm.eighth.duration, duration8)
        let duration4: Double = 16
        XCTAssertEqual(MusicRhythm.quarter.duration, duration4)
        let duration2: Double = 32
        XCTAssertEqual(MusicRhythm.half.duration, duration2)
        let duration1: Double = 64
        XCTAssertEqual(MusicRhythm.whole.duration, duration1)
        let duration0: Double = 128
        XCTAssertEqual(MusicRhythm.breve.duration, duration0)

        let durationDotted32: Double = 3
        XCTAssertEqual(MusicRhythm.dotted(.thirtysecond, dots: 1).duration, durationDotted32)

        let durationDoubleDottedQuarter: Double = MusicRhythm.quarter.duration * 7 / 4
        XCTAssertEqual(MusicRhythm.dotted(.quarter, dots: 2).duration, durationDoubleDottedQuarter)
//
//        let durationDoubleDottedQuarterPlusSixteenth: Double = MusicRhythm.dotted(.quarter, dots: 2).duration + MusicRhythm.sixteenth.duration
//        XCTAssertEqual(duration2, durationDoubleDottedQuarterPlusSixteenth)
//
//        let durationDottedQuarterEighth: Double = MusicRhythm.dotted(.quarter, dots: 1).duration + MusicRhythm.eighth.duration
//        XCTAssertEqual(durationDottedQuarterEighth, duration2)
    }
    
    func testInitFromBaseDuration() {
        //Base duration represents the number of 64th notes that fit into the note
        XCTAssertEqual(MusicRhythm(baseDuration: 1), MusicRhythm.sixtyfourth)
    }
}
