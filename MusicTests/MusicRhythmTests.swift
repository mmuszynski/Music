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
    
    func testMusicRhythmLengths() {
        let duration64 = 1
        XCTAssertEqual(MusicRhythmLength.sixtyfourth.duration, duration64)
        let duration32 = 2
        XCTAssertEqual(MusicRhythmLength.thirtysecond.duration, duration32)
        let duration16 = 4
        XCTAssertEqual(MusicRhythmLength.sixteenth.duration, duration16)
        let duration8 = 8
        XCTAssertEqual(MusicRhythmLength.eighth.duration, duration8)
        let duration4 = 16
        XCTAssertEqual(MusicRhythmLength.quarter.duration, duration4)
        let duration2 = 32
        XCTAssertEqual(MusicRhythmLength.half.duration, duration2)
        let duration1 = 64
        XCTAssertEqual(MusicRhythmLength.whole.duration, duration1)
        let duration0 = 128
        XCTAssertEqual(MusicRhythmLength.breve.duration, duration0)
        
        let durationDotted32 = 3
        XCTAssertEqual(MusicRhythmLength.dotted(length: .thirtysecond).duration, durationDotted32)
        
        let durationDoubleDottedQuarter = MusicRhythmLength.quarter.duration * 7 / 4
        XCTAssertEqual(MusicRhythmLength.dotted(length: .dotted(length: .quarter)).duration, durationDoubleDottedQuarter)
        
        let durationDoubleDottedQuarterPlusSixteenth = MusicRhythmLength.dotted(length: .dotted(length: .quarter)).duration + MusicRhythmLength.sixteenth.duration
        XCTAssertEqual(duration2, durationDoubleDottedQuarterPlusSixteenth)
        
        let durationDottedQuarterEighth = MusicRhythmLength.dotted(length: .quarter).duration + MusicRhythmLength.eighth.duration
        XCTAssertEqual(durationDottedQuarterEighth, duration2)
    }
    
}
