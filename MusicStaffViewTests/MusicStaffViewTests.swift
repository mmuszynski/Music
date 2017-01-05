//
//  MusicStaffViewTests.swift
//  MusicStaffViewTests
//
//  Created by Mike Muszynski on 9/30/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import MusicStaffView

class MusicStaffViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNoteNameCreation() {
        XCTAssertNil(MusicPitchName(stringValue: "bob"))
        
        let a = MusicPitchName.a
        let b = MusicPitchName.b
        let c = MusicPitchName.c
        let d = MusicPitchName.d
        let e = MusicPitchName.e
        let f = MusicPitchName.f
        let g = MusicPitchName.g
        
        var Do = MusicPitchName(stringValue: "Do")
        var Re = MusicPitchName(stringValue: "Re")
        var Mi = MusicPitchName(stringValue: "Mi")
        var Fa = MusicPitchName(stringValue: "Fa")
        var So = MusicPitchName(stringValue: "So")
        var La = MusicPitchName(stringValue: "La")
        var Ti = MusicPitchName(stringValue: "Ti")
        
        XCTAssertEqual(c, Do)
        XCTAssertEqual(d, Re)
        XCTAssertEqual(e, Mi)
        XCTAssertEqual(f, Fa)
        XCTAssertEqual(g, So)
        XCTAssertEqual(a, La)
        XCTAssertEqual(b, Ti)
        
        Do = MusicPitchName(stringValue: "do")
        Re = MusicPitchName(stringValue: "re")
        Mi = MusicPitchName(stringValue: "mi")
        Fa = MusicPitchName(stringValue: "fa")
        So = MusicPitchName(stringValue: "so")
        La = MusicPitchName(stringValue: "la")
        Ti = MusicPitchName(stringValue: "ti")
        
        XCTAssertEqual(c, Do)
        XCTAssertEqual(d, Re)
        XCTAssertEqual(e, Mi)
        XCTAssertEqual(f, Fa)
        XCTAssertEqual(g, So)
        XCTAssertEqual(a, La)
        XCTAssertEqual(b, Ti)
        
        Do = MusicPitchName(stringValue: "C")
        Re = MusicPitchName(stringValue: "D")
        Mi = MusicPitchName(stringValue: "E")
        Fa = MusicPitchName(stringValue: "F")
        So = MusicPitchName(stringValue: "G")
        La = MusicPitchName(stringValue: "A")
        Ti = MusicPitchName(stringValue: "B")
        
        XCTAssertEqual(c, Do)
        XCTAssertEqual(d, Re)
        XCTAssertEqual(e, Mi)
        XCTAssertEqual(f, Fa)
        XCTAssertEqual(g, So)
        XCTAssertEqual(a, La)
        XCTAssertEqual(b, Ti)
    }
    
    func testPitchEquality() {
        var pitch1 = MusicPitch(name: .a, accidental: .natural, octave: 1)
        var pitch2 = MusicPitch(name: .a, accidental: .natural, octave: 1)
        XCTAssertEqual(pitch1, pitch2)
        
        pitch1.name = .b
        XCTAssertNotEqual(pitch1, pitch2)
        pitch2.name = .b
        XCTAssertEqual(pitch1, pitch2)
        
        pitch1.accidental = .none
        XCTAssertNotEqual(pitch1, pitch2)
        pitch2.accidental = .none
        XCTAssertEqual(pitch1, pitch2)
        
        pitch1.octave = 10
        XCTAssertNotEqual(pitch1, pitch2)
    }
    
    func testEnharmonicModifierForName() {
        //c, d, e, f, g, a, b
        //must translate to semitone modifiers
        //0, 2, 4, 5, 7, 9, 11
        let pitchNames: [MusicPitchName] = [.c, .d, .e, .f, .g, .a, .b]
        let modifiers = pitchNames.map { $0.modifier() }
        XCTAssertEqual([0, 2, 4, 5, 7, 9, 11], modifiers)
    }
    
    func testEnharmonicIndices() {
        XCTAssertEqual(MusicPitch(name: .c, accidental: .natural, octave: 0).enharmonicIndex, 0)
        XCTAssertEqual(MusicPitch(name: .c, accidental: .sharp, octave: 0).enharmonicIndex, 1)
        XCTAssertEqual(MusicPitch(name: .d, accidental: .natural, octave: 0).enharmonicIndex, 2)
        XCTAssertEqual(MusicPitch(name: .e, accidental: .flat, octave: 0).enharmonicIndex, 3)
        XCTAssertEqual(MusicPitch(name: .e, accidental: .natural, octave: 0).enharmonicIndex, 4)
        XCTAssertEqual(MusicPitch(name: .f, accidental: .natural, octave: 0).enharmonicIndex, 5)
        XCTAssertEqual(MusicPitch(name: .f, accidental: .sharp, octave: 0).enharmonicIndex, 6)
        XCTAssertEqual(MusicPitch(name: .g, accidental: .natural, octave: 0).enharmonicIndex, 7)
        XCTAssertEqual(MusicPitch(name: .a, accidental: .flat, octave: 0).enharmonicIndex, 8)
        XCTAssertEqual(MusicPitch(name: .a, accidental: .natural, octave: 0).enharmonicIndex, 9)
        XCTAssertEqual(MusicPitch(name: .b, accidental: .flat, octave: 0).enharmonicIndex, 10)
        XCTAssertEqual(MusicPitch(name: .b, accidental: .natural, octave: 0).enharmonicIndex, 11)
        XCTAssertEqual(MusicPitch(name: .c, accidental: .natural, octave: 1).enharmonicIndex, 12)
        XCTAssertEqual(MusicPitch(name: .c, accidental: .sharp, octave: 1).enharmonicIndex, 13)
        XCTAssertEqual(MusicPitch(name: .d, accidental: .natural, octave: 1).enharmonicIndex, 14)
        XCTAssertEqual(MusicPitch(name: .e, accidental: .flat, octave: 1).enharmonicIndex, 15)
        XCTAssertEqual(MusicPitch(name: .e, accidental: .natural, octave: 1).enharmonicIndex, 16)
        XCTAssertEqual(MusicPitch(name: .f, accidental: .natural, octave: 1).enharmonicIndex, 17)
        XCTAssertEqual(MusicPitch(name: .f, accidental: .sharp, octave: 1).enharmonicIndex, 18)
        XCTAssertEqual(MusicPitch(name: .g, accidental: .natural, octave: 1).enharmonicIndex, 19)
        XCTAssertEqual(MusicPitch(name: .a, accidental: .flat, octave: 1).enharmonicIndex, 20)
        XCTAssertEqual(MusicPitch(name: .a, accidental: .natural, octave: 1).enharmonicIndex, 21)
        XCTAssertEqual(MusicPitch(name: .b, accidental: .flat, octave: 1).enharmonicIndex, 22)
        XCTAssertEqual(MusicPitch(name: .b, accidental: .natural, octave: 1).enharmonicIndex, 23)
    }
    
    func testEnharmonicEquivalence() {
        let pitch1 = MusicPitch(name: .a, accidental: .sharp, octave: 1)
        let pitch2 = MusicPitch(name: .b, accidental: .flat, octave: 1)

        XCTAssertEqual(pitch1.enharmonicIndex, pitch2.enharmonicIndex, "\(pitch1.enharmonicIndex) != \(pitch2.enharmonicIndex)")
        XCTAssertTrue(pitch1.isEnharmonicEquivalent(of: pitch2), "\(pitch1.enharmonicIndex) != \(pitch2.enharmonicIndex)")
        
        let eNatural = MusicPitch(name: .e, accidental: .natural, octave: 2)
        let fFlat = MusicPitch(name: .f, accidental: .flat, octave: 2)
        let eNaturalCopy = MusicPitch(name: .e, accidental: .natural, octave: 2)
        let fFlatWrongOctave = MusicPitch(name: .f, accidental: .flat, octave: 3)
        
        XCTAssertTrue(eNatural.isEnharmonicEquivalent(of: fFlat))
        XCTAssertTrue(eNatural.isEnharmonicEquivalent(of: eNaturalCopy))
        XCTAssertFalse(fFlatWrongOctave.isEnharmonicEquivalent(of: eNatural))
    }
    
    func testPitchFromEnharmonicIndexAndAccidental() {
        //Test that A1 is produced when using the EI from A1 and the natural accidental
        let aNatural1 = MusicPitch(name: .a, accidental: .natural, octave: 1)
        let aNaturalEI = MusicPitch(enharmonicIndex: aNatural1.enharmonicIndex, accidental: .natural)
        XCTAssertEqual(aNatural1, aNaturalEI)
        
        //Do the same with B flat, but this time manually entering the EI
        let bFlat1 = MusicPitch(name: .b, accidental: .flat, octave: 1)
        let bFlatEI = MusicPitch(enharmonicIndex: 22, accidental: .flat)
        XCTAssertEqual(bFlat1, bFlatEI)
        
        //Test that various B enharmonics are able to be spelled with various accidentals
        //
        //B natural, octave 1
        XCTAssertNil(MusicPitch(enharmonicIndex: 22, accidental: .natural))
        //A double sharp, octave 1
        XCTAssertNil(MusicPitch(enharmonicIndex: 22, accidental: .doubleSharp))
        //Test that some B enharmonics are not able to be spelled with certain accidentals
        //
        //There is no enharmonic of B that can be spelled with a sharp or a flat
        XCTAssertNotNil(MusicPitch(enharmonicIndex: 22, accidental: .sharp))
        XCTAssertNotNil(MusicPitch(enharmonicIndex: 22, accidental: .flat))
        
        //Test that enharmonics built with the EI are enharmonically equivalent
        let bFlat = MusicPitch(enharmonicIndex: 22, accidental: .flat)
        let aSharp = MusicPitch(enharmonicIndex: 22, accidental: .sharp)
        XCTAssertTrue(bFlat!.isEnharmonicEquivalent(of: aSharp!))
        
        //Test that B0 is spelled properly
        let b0 = MusicPitch(enharmonicIndex: 11, accidental: .natural)
        XCTAssertNotNil(b0)
        XCTAssertEqual(b0?.name, .b)
        XCTAssertEqual(b0?.octave, 0)
    }
    
    func testPitchFromEnharmonicIntervalAndAccidentalEdgeCases() {
        //b#0 has an enharmonic index that will initially put it in octave 1
        //does the EI put it in the right octave?
        XCTAssertEqual(MusicPitch(enharmonicIndex: 12, accidental: .sharp)?.octave, 0)
        
        //b##0?
        XCTAssertEqual(MusicPitch(enharmonicIndex: 13, accidental: .doubleSharp)?.octave, 0)
        
        //similar story with Cb1 and Cbb1
        XCTAssertEqual(MusicPitch(enharmonicIndex: 11, accidental: .flat)?.octave, 1)
        XCTAssertEqual(MusicPitch(enharmonicIndex: 10, accidental: .doubleFlat)?.octave, 1)
    }
    
    func testPitchFromEnharmonicCFlatEdgeCase() {
        let cFlat1 = MusicPitch(enharmonicIndex: 11, accidental: .flat)
        XCTAssertNotNil(cFlat1)
        XCTAssertEqual(cFlat1?.name, .c)
        XCTAssertEqual(cFlat1?.octave, 1)
    }
    
    func testAllEnharmonics() {
        //Test to make sure that all possible enharmonics are generated
        let aSharp0 = MusicPitch(name: .a, accidental: .sharp, octave: 0)
        let bFlat0 = MusicPitch(name: .b, accidental: .flat, octave: 0)
        let Cbb1 = MusicPitch(name: .c, accidental: .doubleFlat, octave: 1)
        
        let testSet = Set<MusicPitch>([aSharp0, bFlat0, Cbb1])
        XCTAssertEqual(aSharp0.allEnharmonics(), testSet)
        XCTAssertEqual(bFlat0.allEnharmonics(), testSet)
        XCTAssertEqual(Cbb1.allEnharmonics(), testSet)
    }
    
    func testComparisons() {
        let C0 = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let Csharp0 = MusicPitch(name: .c, accidental: .sharp, octave: 0)
        XCTAssertGreaterThan(Csharp0, C0)
        XCTAssertLessThan(C0, Csharp0)
        
        let D0 = MusicPitch(name: .d, accidental: .natural, octave: 0)
        let ordered = [C0, Csharp0, D0]
        let sorted = [D0, Csharp0, C0].sorted()
        XCTAssertEqual(ordered, sorted)
        
        let Db0 = MusicPitch(name: .d, accidental: .flat, octave: 0)
        let Dsharp0 = MusicPitch(name: .d, accidental: .sharp, octave: 0)
        let Eb0 = MusicPitch(name: .e, accidental: .flat, octave: 0)
        let larger = [C0, Csharp0, Db0, D0, Dsharp0, Eb0]
        let sortedLarger = [D0, Eb0, Csharp0, Dsharp0, C0, Db0].sorted()
        XCTAssertEqual(larger, sortedLarger)
    }
    
}
