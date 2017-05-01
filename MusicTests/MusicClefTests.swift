//
//  MusicClefTests.swift
//  Music
//
//  Created by Mike Muszynski on 1/5/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import Music

class MusicClefTests: XCTestCase {
    
    func testClefOffset() {
        let bassClef = MusicClef.bass
        for octave in 0...8 {
            for pitch in [.c, .d, .e, .f, .g, .a] as [MusicPitchName] {
                let offset = -22 + pitch.rawValue + 7 * octave
                XCTAssertEqual(bassClef.pitch(forOffset: offset), MusicPitch(name: pitch, accidental: .none, octave: octave))
                XCTAssertEqual(bassClef.offsetForPitch(named: pitch, octave: octave), offset)
            }
        }
    }
    
    func testCleffOffsetAlto() {
        let altoClef = MusicClef.alto
        for octave in 0...8 {
            for pitch in [.c, .d, .e, .f, .g, .a, .b] as [MusicPitchName] {
                let offset = -28 + pitch.rawValue + 7 * octave
                print(offset)
                XCTAssertEqual(altoClef.pitch(forOffset: offset), MusicPitch(name: pitch, accidental: .none, octave: octave))
                XCTAssertEqual(altoClef.offsetForPitch(named: pitch, octave: octave), offset)
            }
        }
    }
    
    func testClefOffsetTreble() {
        let trebleClef = MusicClef.treble
        for octave in 0...8 {
            for pitch in [.c, .d, .e, .f, .g, .a, .b] as [MusicPitchName] {
                let offset = -34 + pitch.rawValue + 7 * octave
                print(offset)
                XCTAssertEqual(trebleClef.pitch(forOffset: offset), MusicPitch(name: pitch, accidental: .none, octave: octave))
                XCTAssertEqual(trebleClef.offsetForPitch(named: pitch, octave: octave), offset)
            }
        }
        
    }
    
    func testClefOffsetTenor() {
        let tenor = MusicClef.tenor
        for octave in 0...8 {
            for pitch in [.c, .d, .e, .f, .g, .a, .b] as [MusicPitchName] {
                let offset = -26 + pitch.rawValue + 7 * octave
                print(offset)
                XCTAssertEqual(tenor.pitch(forOffset: offset), MusicPitch(name: pitch, accidental: .none, octave: octave))
                XCTAssertEqual(tenor.offsetForPitch(named: pitch, octave: octave), offset)
            }
        }
        
    }
    
    func testGenericClefBaritone() {
        let baritoneClef = MusicClef.cClef(offset: 4)
        for octave in 0...8 {
            for pitch in [.c, .d, .e, .f, .g, .a, .b] as [MusicPitchName] {
                let offset = -24 + pitch.rawValue + 7 * octave
                print(offset)
                XCTAssertEqual(baritoneClef.pitch(forOffset: offset), MusicPitch(name: pitch, accidental: .none, octave: octave))
                XCTAssertEqual(baritoneClef.offsetForPitch(named: pitch, octave: octave), offset)
            }
        }
    }
    
    func testEquality() {
        let trebleClef = MusicClef.gClef(offset: -2)
        let otherTreble = MusicClef.treble
        XCTAssertEqual(trebleClef, otherTreble)
    }
}
