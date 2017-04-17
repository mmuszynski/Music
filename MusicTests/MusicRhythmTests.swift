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
        let duration64 = 1
        XCTAssertEqual(MusicRhythm.sixtyfourth.duration, duration64)
        let duration32 = 2
        XCTAssertEqual(MusicRhythm.thirtysecond.duration, duration32)
        let duration16 = 4
        XCTAssertEqual(MusicRhythm.sixteenth.duration, duration16)
        let duration8 = 8
        XCTAssertEqual(MusicRhythm.eighth.duration, duration8)
        let duration4 = 16
        XCTAssertEqual(MusicRhythm.quarter.duration, duration4)
        let duration2 = 32
        XCTAssertEqual(MusicRhythm.half.duration, duration2)
        let duration1 = 64
        XCTAssertEqual(MusicRhythm.whole.duration, duration1)
        let duration0 = 128
        XCTAssertEqual(MusicRhythm.breve.duration, duration0)
        
        let durationDotted32 = 3
        XCTAssertEqual(MusicRhythm.dotted(length: .thirtysecond).duration, durationDotted32)
        
        let durationDoubleDottedQuarter = MusicRhythm.quarter.duration * 7 / 4
        XCTAssertEqual(MusicRhythm.dotted(length: .dotted(length: .quarter)).duration, durationDoubleDottedQuarter)
        
        let durationDoubleDottedQuarterPlusSixteenth = MusicRhythm.dotted(length: .dotted(length: .quarter)).duration + MusicRhythm.sixteenth.duration
        XCTAssertEqual(duration2, durationDoubleDottedQuarterPlusSixteenth)
        
        let durationDottedQuarterEighth = MusicRhythm.dotted(length: .quarter).duration + MusicRhythm.eighth.duration
        XCTAssertEqual(durationDottedQuarterEighth, duration2)
    }
    
}
