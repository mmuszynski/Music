//
//  MusicChordTests.swift
//  Music
//
//  Created by Mike Muszynski on 3/31/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import Music

class MusicChordTests: XCTestCase {
    
    func testChordCreation() {
        let C0 = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let Edur0 = MusicPitch(name: .e, accidental: .flat, octave: 0)
        let E0 = MusicPitch(name: .e, accidental: .natural, octave: 0)
        let G0 = MusicPitch(name: .g, accidental: .natural, octave: 0)
        let Gdur0 = MusicPitch(name: .g, accidental: .flat, octave: 0)
        let Gis0 = MusicPitch(name: .g, accidental: .sharp, octave: 0)
        let B0 = MusicPitch(name: .b, accidental: .natural, octave: 0)
        let Bdur0 = MusicPitch(name: .b, accidental: .flat, octave: 0)
        let Bbb0 = MusicPitch(name: .b, accidental: .doubleFlat, octave: 0)
        
        let cMajorTriad = try! MusicChord(root: C0, type: .majorTriad)
        let cMinorTriad = try! MusicChord(root: C0, type: .minorTriad)
        let cDiminishedTriad = try! MusicChord(root: C0, type: .diminishedTriad)
        let cAugmentedTriad = try! MusicChord(root: C0, type: .augmentedTriad)
        let cMajorSeventh = try! MusicChord(root: C0, type: .majorSeventh)
        let cDominantSeventh = try! MusicChord(root: C0, type: .dominantSeventh)
        let cMinorSeventh = try! MusicChord(root: C0, type: .minorSeventh)
        let cHalfDiminishedSeventh = try! MusicChord(root: C0, type: .halfDiminishedSeventh)
        let cFullyDiminishedSeventh = try! MusicChord(root: C0, type: .fullyDiminishedSeventh)
        
        XCTAssert(cMajorTriad == [C0, E0, G0])
        XCTAssert(cMinorTriad == [C0, Edur0, G0])
        XCTAssert(cDiminishedTriad == [C0, Edur0, Gdur0])
        XCTAssert(cAugmentedTriad == [C0, E0, Gis0])
        XCTAssert(cMajorSeventh == [C0, E0, G0, B0])
        XCTAssert(cDominantSeventh == [C0, E0, G0, Bdur0])
        XCTAssert(cMinorSeventh == [C0, Edur0, G0, Bdur0])
        XCTAssert(cHalfDiminishedSeventh == [C0, Edur0, Gdur0, Bdur0])
        XCTAssert(cFullyDiminishedSeventh == [C0, Edur0, Gdur0, Bbb0])
    }
    
    func testGenericChord() {
        let C0 = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let E0 = MusicPitch(name: .e, accidental: .natural, octave: 0)
        let G0 = MusicPitch(name: .g, accidental: .natural, octave: 0)
        
        let genericMajorTriad = try! MusicChordType.genericType(fromNotes: [C0, E0, G0])
        let majorTriad = MusicChordType.majorTriad
        
        let genericChord = try! MusicChord(root: C0, type: genericMajorTriad)
        let majorChord = try! MusicChord(root: C0, type: majorTriad)
        
        XCTAssertEqual(genericChord, majorChord)
        XCTAssertEqual(genericChord.type, majorChord.type)
    }
    
    func testChordTransposition() {
        let C0 = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let E0 = MusicPitch(name: .e, accidental: .natural, octave: 0)
        let G0 = MusicPitch(name: .g, accidental: .natural, octave: 0)
        let Cis0 = MusicPitch(name: .c, accidental: .sharp, octave: 0)
        let Eis0 = MusicPitch(name: .e, accidental: .sharp, octave: 0)
        let Gis0 = MusicPitch(name: .g, accidental: .sharp, octave: 0)
        
        let cMajorTriad = try! MusicChord(root: C0, type: MusicChordType.majorTriad)
        let cisMajorTriad = try! MusicChord(root: Cis0, type: MusicChordType.majorTriad)
        
        XCTAssert(cMajorTriad == [C0, E0, G0])
        XCTAssert(cisMajorTriad == [Cis0, Eis0, Gis0])

        let cis = try! cMajorTriad.transposed(by: MusicInterval(direction: .upward, quality: .augmented, quantity: .unison))
        XCTAssertEqual(cis, cisMajorTriad)
    }
    
}
