//
//  MusicScaleTests.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/16/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import MusicStaffView

class MusicScaleTests: XCTestCase {
    
    func testEnumeration() {
        let root = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let scale = MusicScale(root: root, mode: .major)
        for note in scale {
            
        }
    }
    
    func testCMajorScale() {
        let root = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let scale = MusicScale(root: root, mode: .major)
        let cMajor = [root,
                      MusicPitch(name: .d, accidental: .natural, octave: 0),
                      MusicPitch(name: .e, accidental: .natural, octave: 0),
                      MusicPitch(name: .f, accidental: .natural, octave: 0),
                      MusicPitch(name: .g, accidental: .natural, octave: 0),
                      MusicPitch(name: .a, accidental: .natural, octave: 0),
                      MusicPitch(name: .b, accidental: .natural, octave: 0),
                      MusicPitch(name: .c, accidental: .natural, octave: 1)]
        XCTAssert(scale == cMajor)
        XCTAssert(scale.count == 8)
    }
    
    func testEMajorScale() {
        let root = MusicPitch(name: .e, accidental: .natural, octave: 0)
        let scale = MusicScale(root: root, mode: .major)
        let eMajor = [root,
                      MusicPitch(name: .f, accidental: .sharp, octave: 0),
                      MusicPitch(name: .g, accidental: .sharp, octave: 0),
                      MusicPitch(name: .a, accidental: .natural, octave: 0),
                      MusicPitch(name: .b, accidental: .natural, octave: 0),
                      MusicPitch(name: .c, accidental: .sharp, octave: 1),
                      MusicPitch(name: .d, accidental: .sharp, octave: 1),
                      MusicPitch(name: .e, accidental: .natural, octave: 1)]
        XCTAssert(scale == eMajor)
    }
    
    func testCSharpMajorScale() {
        let root = MusicPitch(name: .c, accidental: .sharp, octave: 0)
        let scale = MusicScale(root: root, mode: .major)
        let cSharpMajor = [root,
                      MusicPitch(name: .d, accidental: .sharp, octave: 0),
                      MusicPitch(name: .e, accidental: .sharp, octave: 0),
                      MusicPitch(name: .f, accidental: .sharp, octave: 0),
                      MusicPitch(name: .g, accidental: .sharp, octave: 0),
                      MusicPitch(name: .a, accidental: .sharp, octave: 0),
                      MusicPitch(name: .b, accidental: .sharp, octave: 0),
                      MusicPitch(name: .c, accidental: .sharp, octave: 1)]
        XCTAssert(scale == cSharpMajor)
    }
    
    func testDHarmonicMinorScale() {
        let root = MusicPitch(name: .d, accidental: .natural, octave: 0)
        let scale = MusicScale(root: root, mode: .harmonicMinor)
        let dMinor = [root,
                      MusicPitch(name: .e, accidental: .natural, octave: 0),
                      MusicPitch(name: .f, accidental: .natural, octave: 0),
                      MusicPitch(name: .g, accidental: .natural, octave: 0),
                      MusicPitch(name: .a, accidental: .natural, octave: 0),
                      MusicPitch(name: .b, accidental: .flat, octave: 0),
                      MusicPitch(name: .c, accidental: .sharp, octave: 1),
                      MusicPitch(name: .d, accidental: .natural, octave: 1)]
        XCTAssert(scale == dMinor, "\(scale)")
    }
    
    func testCSharpNaturalMinorScale() {
        let root = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let scale = MusicScale(root: root, mode: .naturalMinor)
        let dMinor = [root,
                      MusicPitch(name: .d, accidental: .natural, octave: 0),
                      MusicPitch(name: .e, accidental: .flat, octave: 0),
                      MusicPitch(name: .f, accidental: .natural, octave: 0),
                      MusicPitch(name: .g, accidental: .natural, octave: 0),
                      MusicPitch(name: .a, accidental: .flat, octave: 0),
                      MusicPitch(name: .b, accidental: .flat, octave: 0),
                      MusicPitch(name: .c, accidental: .natural, octave: 0)]
        XCTAssert(scale == dMinor, "\(scale)")
    }
    
    func testCMelodicMinorScale() {
        let root = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let scale = MusicScale(root: root, mode: .melodicMinor)
        let cMinor = [root,
                      MusicPitch(name: .d, accidental: .natural, octave: 0),
                      MusicPitch(name: .e, accidental: .flat, octave: 0),
                      MusicPitch(name: .f, accidental: .natural, octave: 0),
                      MusicPitch(name: .g, accidental: .natural, octave: 0),
                      MusicPitch(name: .a, accidental: .natural, octave: 0),
                      MusicPitch(name: .b, accidental: .natural, octave: 0),
                      MusicPitch(name: .c, accidental: .natural, octave: 1),
                      MusicPitch(name: .b, accidental: .flat, octave: 0),
                      MusicPitch(name: .a, accidental: .flat, octave: 0),
                      MusicPitch(name: .g, accidental: .natural, octave: 0),
                      MusicPitch(name: .f, accidental: .natural, octave: 0),
                      MusicPitch(name: .e, accidental: .flat, octave: 0),
                      MusicPitch(name: .d, accidental: .natural, octave: 0),
                      MusicPitch(name: .c, accidental: .natural, octave: 0)]
        XCTAssert(scale == cMinor, "\(scale)")
    }
    
    func testMajorPentatonic() {
        let root = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let scale = MusicScale(root: root, mode: .majorPentatonic)
        let cPent = [root,
                    MusicPitch(name: .d, accidental: .natural, octave: 0),
                    MusicPitch(name: .e, accidental: .flat, octave: 0),
                    MusicPitch(name: .g, accidental: .natural, octave: 0),
                    MusicPitch(name: .a, accidental: .natural, octave: 0),
                    MusicPitch(name: .c, accidental: .natural, octave: 1)]
        XCTAssert(scale == cPent, "\(scale)")
    }
}