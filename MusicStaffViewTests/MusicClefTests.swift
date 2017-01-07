//
//  MusicClefTests.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/5/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import MusicStaffView

class MusicClefTests: XCTestCase {
    
    func testClefOffset() {
        let bassClef = MusicClefType.bass
        XCTAssertEqual(bassClef.pitch(forOffset: -9), MusicPitch(name: .b, accidental: .none, octave: 1))
        XCTAssertEqual(bassClef.pitch(forOffset: -8), MusicPitch(name: .c, accidental: .none, octave: 2))
        XCTAssertEqual(bassClef.pitch(forOffset: -7), MusicPitch(name: .d, accidental: .none, octave: 2))
        XCTAssertEqual(bassClef.pitch(forOffset: -6), MusicPitch(name: .e, accidental: .none, octave: 2))
        XCTAssertEqual(bassClef.pitch(forOffset: -5), MusicPitch(name: .f, accidental: .none, octave: 2))
        XCTAssertEqual(bassClef.pitch(forOffset: -4), MusicPitch(name: .g, accidental: .none, octave: 2))
        XCTAssertEqual(bassClef.pitch(forOffset: -3), MusicPitch(name: .a, accidental: .none, octave: 2))
        XCTAssertEqual(bassClef.pitch(forOffset: -2), MusicPitch(name: .b, accidental: .none, octave: 2))
        XCTAssertEqual(bassClef.pitch(forOffset: -1), MusicPitch(name: .c, accidental: .none, octave: 3))
        XCTAssertEqual(bassClef.pitch(forOffset: 0), MusicPitch(name: .d, accidental: .none, octave: 3))
        XCTAssertEqual(bassClef.pitch(forOffset: 1), MusicPitch(name: .e, accidental: .none, octave: 3))
        XCTAssertEqual(bassClef.pitch(forOffset: 2), MusicPitch(name: .f, accidental: .none, octave: 3))
        XCTAssertEqual(bassClef.pitch(forOffset: 3), MusicPitch(name: .g, accidental: .none, octave: 3))
        XCTAssertEqual(bassClef.pitch(forOffset: 4), MusicPitch(name: .a, accidental: .none, octave: 3))
        XCTAssertEqual(bassClef.pitch(forOffset: 5), MusicPitch(name: .b, accidental: .none, octave: 3))
        XCTAssertEqual(bassClef.pitch(forOffset: 6), MusicPitch(name: .c, accidental: .none, octave: 4))
        XCTAssertEqual(bassClef.pitch(forOffset: 7), MusicPitch(name: .d, accidental: .none, octave: 4))
        XCTAssertEqual(bassClef.pitch(forOffset: 8), MusicPitch(name: .e, accidental: .none, octave: 4))
        XCTAssertEqual(bassClef.pitch(forOffset: 9), MusicPitch(name: .f, accidental: .none, octave: 4))
        XCTAssertEqual(bassClef.pitch(forOffset: 10), MusicPitch(name: .g, accidental: .none, octave: 4))
        XCTAssertEqual(bassClef.pitch(forOffset: 11), MusicPitch(name: .a, accidental: .none, octave: 4))
        XCTAssertEqual(bassClef.pitch(forOffset: 12), MusicPitch(name: .b, accidental: .none, octave: 4))
        XCTAssertEqual(bassClef.pitch(forOffset: 13), MusicPitch(name: .c, accidental: .none, octave: 5))
    }
    
    func testCleffOffsetAlto() {
    
        let altoClef = MusicClefType.alto
        XCTAssertEqual(altoClef.pitch(forOffset: -9), MusicPitch(name: .a, accidental: .none, octave: 2))
        XCTAssertEqual(altoClef.pitch(forOffset: -8), MusicPitch(name: .b, accidental: .none, octave: 2))
        XCTAssertEqual(altoClef.pitch(forOffset: -7), MusicPitch(name: .c, accidental: .none, octave: 3))
        XCTAssertEqual(altoClef.pitch(forOffset: -6), MusicPitch(name: .d, accidental: .none, octave: 3))
        XCTAssertEqual(altoClef.pitch(forOffset: -5), MusicPitch(name: .e, accidental: .none, octave: 3))
        XCTAssertEqual(altoClef.pitch(forOffset: -4), MusicPitch(name: .f, accidental: .none, octave: 3))
        XCTAssertEqual(altoClef.pitch(forOffset: -3), MusicPitch(name: .g, accidental: .none, octave: 3))
        XCTAssertEqual(altoClef.pitch(forOffset: -2), MusicPitch(name: .a, accidental: .none, octave: 3))
        XCTAssertEqual(altoClef.pitch(forOffset: -1), MusicPitch(name: .b, accidental: .none, octave: 3))
        XCTAssertEqual(altoClef.pitch(forOffset: 0), MusicPitch(name: .c, accidental: .none, octave: 4))
        XCTAssertEqual(altoClef.pitch(forOffset: 1), MusicPitch(name: .d, accidental: .none, octave: 4))
        XCTAssertEqual(altoClef.pitch(forOffset: 2), MusicPitch(name: .e, accidental: .none, octave: 4))
        XCTAssertEqual(altoClef.pitch(forOffset: 3), MusicPitch(name: .f, accidental: .none, octave: 4))
        XCTAssertEqual(altoClef.pitch(forOffset: 4), MusicPitch(name: .g, accidental: .none, octave: 4))
        XCTAssertEqual(altoClef.pitch(forOffset: 5), MusicPitch(name: .a, accidental: .none, octave: 4))
        XCTAssertEqual(altoClef.pitch(forOffset: 6), MusicPitch(name: .b, accidental: .none, octave: 4))
        XCTAssertEqual(altoClef.pitch(forOffset: 7), MusicPitch(name: .c, accidental: .none, octave: 5))
        XCTAssertEqual(altoClef.pitch(forOffset: 8), MusicPitch(name: .d, accidental: .none, octave: 5))
        XCTAssertEqual(altoClef.pitch(forOffset: 9), MusicPitch(name: .e, accidental: .none, octave: 5))
        
    }
    
    func testClefOffsetTreble() {
    
        let trebleClef = MusicClefType.treble
        XCTAssertEqual(trebleClef.pitch(forOffset: -9), MusicPitch(name: .g, accidental: .none, octave: 3))
        XCTAssertEqual(trebleClef.pitch(forOffset: -8), MusicPitch(name: .a, accidental: .none, octave: 3))
        XCTAssertEqual(trebleClef.pitch(forOffset: -7), MusicPitch(name: .b, accidental: .none, octave: 3))
        XCTAssertEqual(trebleClef.pitch(forOffset: -6), MusicPitch(name: .c, accidental: .none, octave: 4))
        XCTAssertEqual(trebleClef.pitch(forOffset: -5), MusicPitch(name: .d, accidental: .none, octave: 4))
        XCTAssertEqual(trebleClef.pitch(forOffset: -4), MusicPitch(name: .e, accidental: .none, octave: 4))
        XCTAssertEqual(trebleClef.pitch(forOffset: -3), MusicPitch(name: .f, accidental: .none, octave: 4))
        XCTAssertEqual(trebleClef.pitch(forOffset: -2), MusicPitch(name: .g, accidental: .none, octave: 4))
        XCTAssertEqual(trebleClef.pitch(forOffset: -1), MusicPitch(name: .a, accidental: .none, octave: 4))
        XCTAssertEqual(trebleClef.pitch(forOffset: 0), MusicPitch(name: .b, accidental: .none, octave: 4))
        XCTAssertEqual(trebleClef.pitch(forOffset: 1), MusicPitch(name: .c, accidental: .none, octave: 5))
        XCTAssertEqual(trebleClef.pitch(forOffset: 2), MusicPitch(name: .d, accidental: .none, octave: 5))
        XCTAssertEqual(trebleClef.pitch(forOffset: 3), MusicPitch(name: .e, accidental: .none, octave: 5))
        XCTAssertEqual(trebleClef.pitch(forOffset: 4), MusicPitch(name: .f, accidental: .none, octave: 5))
        XCTAssertEqual(trebleClef.pitch(forOffset: 5), MusicPitch(name: .g, accidental: .none, octave: 5))
        XCTAssertEqual(trebleClef.pitch(forOffset: 6), MusicPitch(name: .a, accidental: .none, octave: 5))
        XCTAssertEqual(trebleClef.pitch(forOffset: 7), MusicPitch(name: .b, accidental: .none, octave: 5))
        XCTAssertEqual(trebleClef.pitch(forOffset: 8), MusicPitch(name: .c, accidental: .none, octave: 6))
        XCTAssertEqual(trebleClef.pitch(forOffset: 9), MusicPitch(name: .d, accidental: .none, octave: 6))
        
    }
    
    func testClefOffsetTenor() {
    
        let tenorClef = MusicClefType.tenor
        XCTAssertEqual(tenorClef.pitch(forOffset: -9), MusicPitch(name: .f, accidental: .none, octave: 2))
        XCTAssertEqual(tenorClef.pitch(forOffset: -8), MusicPitch(name: .g, accidental: .none, octave: 2))
        XCTAssertEqual(tenorClef.pitch(forOffset: -7), MusicPitch(name: .a, accidental: .none, octave: 2))
        XCTAssertEqual(tenorClef.pitch(forOffset: -6), MusicPitch(name: .b, accidental: .none, octave: 2))
        XCTAssertEqual(tenorClef.pitch(forOffset: -5), MusicPitch(name: .c, accidental: .none, octave: 3))
        XCTAssertEqual(tenorClef.pitch(forOffset: -4), MusicPitch(name: .d, accidental: .none, octave: 3))
        XCTAssertEqual(tenorClef.pitch(forOffset: -3), MusicPitch(name: .e, accidental: .none, octave: 3))
        XCTAssertEqual(tenorClef.pitch(forOffset: -2), MusicPitch(name: .f, accidental: .none, octave: 3))
        XCTAssertEqual(tenorClef.pitch(forOffset: -1), MusicPitch(name: .g, accidental: .none, octave: 3))
        XCTAssertEqual(tenorClef.pitch(forOffset: 0), MusicPitch(name: .a, accidental: .none, octave: 3))
        XCTAssertEqual(tenorClef.pitch(forOffset: 1), MusicPitch(name: .b, accidental: .none, octave: 3))
        XCTAssertEqual(tenorClef.pitch(forOffset: 2), MusicPitch(name: .c, accidental: .none, octave: 4))
        XCTAssertEqual(tenorClef.pitch(forOffset: 3), MusicPitch(name: .d, accidental: .none, octave: 4))
        XCTAssertEqual(tenorClef.pitch(forOffset: 4), MusicPitch(name: .e, accidental: .none, octave: 4))
        XCTAssertEqual(tenorClef.pitch(forOffset: 5), MusicPitch(name: .f, accidental: .none, octave: 4))
        XCTAssertEqual(tenorClef.pitch(forOffset: 6), MusicPitch(name: .g, accidental: .none, octave: 4))
        XCTAssertEqual(tenorClef.pitch(forOffset: 7), MusicPitch(name: .a, accidental: .none, octave: 4))
        XCTAssertEqual(tenorClef.pitch(forOffset: 8), MusicPitch(name: .b, accidental: .none, octave: 4))
        XCTAssertEqual(tenorClef.pitch(forOffset: 9), MusicPitch(name: .c, accidental: .none, octave: 5))
        
    }
    
    func testGenericClefBaritone() {
        let baritoneClef = MusicClefType.genericCClef(offset: 4)
        XCTAssertEqual(baritoneClef.pitch(forOffset: 0), MusicPitch(name: .f, accidental: .none, octave: 3))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 1), MusicPitch(name: .g, accidental: .none, octave: 3))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 2), MusicPitch(name: .a, accidental: .none, octave: 3))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 3), MusicPitch(name: .b, accidental: .none, octave: 3))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 4), MusicPitch(name: .c, accidental: .none, octave: 4))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 5), MusicPitch(name: .d, accidental: .none, octave: 4))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 6), MusicPitch(name: .e, accidental: .none, octave: 4))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 7), MusicPitch(name: .f, accidental: .none, octave: 4))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 8), MusicPitch(name: .g, accidental: .none, octave: 4))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 9), MusicPitch(name: .a, accidental: .none, octave: 4))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 10), MusicPitch(name: .b, accidental: .none, octave: 4))
        XCTAssertEqual(baritoneClef.pitch(forOffset: 11), MusicPitch(name: .c, accidental: .none, octave: 5))

    }
    
}
