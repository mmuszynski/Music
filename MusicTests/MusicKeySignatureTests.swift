//
//  MusicKeySignatureTests.swift
//  Music
//
//  Created by Mike Muszynski on 4/3/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import Music

class KeySignatureTests: XCTestCase {
    
    func pitchTupleToMusicPitchAccidental(tuple: (MusicPitchName, MusicAccidental)) -> MusicPitchAccidental {
        return MusicPitchAccidental(name: tuple.0, accidental: tuple.1)
    }

    func testKeySignaturesAllNatural() {
        let major = MusicKeySignature.cMajor
        let minor = MusicKeySignature.aMinor
        
        XCTAssertEqual(major.pitches.count, 0)
        XCTAssertEqual(minor.pitches.count, 0)
        
        XCTAssertEqual(major.pitches, [])
        XCTAssertEqual(minor.pitches, [])
    }
    
    func testKeySignaturesOneFlat() {
        let testPitches = [(.b, .flat)].map(pitchTupleToMusicPitchAccidental)
        
        let major = MusicKeySignature.fMajor
        let minor = MusicKeySignature.dMinor
        XCTAssertEqual(major.pitches.count, 1)
        XCTAssertEqual(minor.pitches.count, 1)
        XCTAssertEqual(major.pitches, testPitches)
        XCTAssertEqual(minor.pitches, testPitches)
    }
    
    func testKeySignaturesTwoFlats() {
        let testPitches = [(.b, .flat),
                           (.e, .flat)].map(pitchTupleToMusicPitchAccidental)
        
        let major = MusicKeySignature.bFlatMajor
        let minor = MusicKeySignature.gMinor
        XCTAssertEqual(major.pitches.count, 2)
        XCTAssertEqual(minor.pitches.count, 2)
        XCTAssertEqual(major.pitches, testPitches)
        XCTAssertEqual(minor.pitches, testPitches)
    }
    
    func testKeySignaturesThreeFlats() {
        let testPitches = [(.b, .flat),
                           (.e, .flat),
                           (.a, .flat)].map(pitchTupleToMusicPitchAccidental)
        
        let major = MusicKeySignature.eFlatMajor
        let minor = MusicKeySignature.cMinor
        XCTAssertEqual(major.pitches.count, 3)
        XCTAssertEqual(minor.pitches.count, 3)
        XCTAssertEqual(major.pitches, testPitches)
        XCTAssertEqual(minor.pitches, testPitches)
    }
    
    func testKeySignaturesFourFlats() {
        let testPitches = [(.b, .flat),
                           (.e, .flat),
                           (.a, .flat),
                           (.d, .flat)].map(pitchTupleToMusicPitchAccidental)
        
        let major = MusicKeySignature.aFlatMajor
        let minor = MusicKeySignature.fMinor
        XCTAssertEqual(major.pitches.count, 4)
        XCTAssertEqual(minor.pitches.count, 4)
        XCTAssertEqual(major.pitches, testPitches)
        XCTAssertEqual(minor.pitches, testPitches)
    }
    
    func testKeySignaturesFiveFlats() {
        let testPitches = [(.b, .flat),
                           (.e, .flat),
                           (.a, .flat),
                           (.d, .flat),
                           (.g, .flat)].map(pitchTupleToMusicPitchAccidental)
        
        let major = MusicKeySignature.dFlatMajor
        let minor = MusicKeySignature.bFlatMinor
        XCTAssertEqual(major.pitches.count, 5)
        XCTAssertEqual(minor.pitches.count, 5)
        XCTAssertEqual(major.pitches, testPitches)
        XCTAssertEqual(minor.pitches, testPitches)
    }
    
    func testKeySignaturesSixFlats() {
        let testPitches = [(.b, .flat),
                           (.e, .flat),
                           (.a, .flat),
                           (.d, .flat),
                           (.g, .flat),
                           (.c, .flat)].map(pitchTupleToMusicPitchAccidental)
        
        let major = MusicKeySignature.gFlatMajor
        let minor = MusicKeySignature.eFlatMinor
        XCTAssertEqual(major.pitches.count, 6)
        XCTAssertEqual(minor.pitches.count, 6)
        XCTAssertEqual(major.pitches, testPitches)
        XCTAssertEqual(minor.pitches, testPitches)
    }
    
    func testKeySignaturesSevenFlats() {
        let testPitches = [(.b, .flat),
                           (.e, .flat),
                           (.a, .flat),
                           (.d, .flat),
                           (.g, .flat),
                           (.c, .flat),
                           (.f, .flat)].map(pitchTupleToMusicPitchAccidental)
        
        let major = MusicKeySignature.cFlatMajor
        let minor = MusicKeySignature.aFlatMinor
        XCTAssertEqual(major.pitches.count, 7)
        XCTAssertEqual(minor.pitches.count, 7)
        XCTAssertEqual(major.pitches, testPitches)
        XCTAssertEqual(minor.pitches, testPitches)
    }

}
