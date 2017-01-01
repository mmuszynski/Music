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
    }
    
    func testEnharmonicModifierForName() {
        //c, d, e, f, g, a, b
        //must translate to semitone modifiers
        //0, 2, 4, 5, 7, 9, 11
        let pitchNames: [MusicPitchName] = [.c, .d, .e, .f, .g, .a, .b]
        let modifiers = pitchNames.map { $0.modifier() }
        XCTAssertEqual([0, 2, 4, 5, 7, 9, 11], modifiers)
    }
    
    func testEnharmonicEquivalence() {
        let pitch1 = MusicPitch(name: .a, accidental: .sharp, octave: 1)
        let pitch2 = MusicPitch(name: .b, accidental: .flat, octave: 1)

        XCTAssertEqual(pitch1.enharmonicIndex, pitch2.enharmonicIndex, "\(pitch1.enharmonicIndex) != \(pitch2.enharmonicIndex)")
        XCTAssertTrue(pitch1.isEnharmonicEquivalent(of: pitch2), "\(pitch1.enharmonicIndex) != \(pitch2.enharmonicIndex)")
    }
    
    func testPitchFromEnharmonic() {
        let aNatural1 = MusicPitch(name: .a, accidental: .natural, octave: 1)
        let aNaturalEI = MusicPitch(enharmonicIndex: aNatural1.enharmonicIndex, accidental: .natural)
        
        XCTAssertTrue(aNatural1 == aNaturalEI)
    }
    
    func testMajorScales() {
        
    }
    
    func testMinorScales() {
        
    }
    
}
