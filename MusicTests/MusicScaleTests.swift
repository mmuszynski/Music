//
//  MusicScaleTests.swift
//  Music
//
//  Created by Mike Muszynski on 1/16/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import Music

class MusicScaleTests: XCTestCase {
    
    func testEnumeration() {
        let root = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let scale = try! MusicScale(root: root, mode: .major)
        for _ in scale {
            
        }
    }
    
    func testCMajorScale() {
        let root = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let up = try! MusicScale(root: root, mode: .major, direction: .up)
        let cMajor = [root,
                      MusicPitch(name: .d, accidental: .natural, octave: 0),
                      MusicPitch(name: .e, accidental: .natural, octave: 0),
                      MusicPitch(name: .f, accidental: .natural, octave: 0),
                      MusicPitch(name: .g, accidental: .natural, octave: 0),
                      MusicPitch(name: .a, accidental: .natural, octave: 0),
                      MusicPitch(name: .b, accidental: .natural, octave: 0),
                      MusicPitch(name: .c, accidental: .natural, octave: 1)]
        XCTAssert(up == cMajor)
        XCTAssert(up.count == 8)
        
        do {
            let down = try MusicScale(root: root, mode: .major, direction: .down)
            XCTAssert(down == cMajor.reversed())
            XCTAssert(down.count == 8)
        } catch {
            XCTFail("\(error)")
        }
        
        let circular = try! MusicScale(root: root, mode: .major)
        let full = Array<MusicPitch>(cMajor[0..<7] + cMajor.reversed())
        XCTAssert(circular == full)
    }
    
    func testEMajorScale() {
        let root = MusicPitch(name: .e, accidental: .natural, octave: 0)
        let scale = try! MusicScale(root: root, mode: .major, direction: .up)
        let eMajor = [root,
                      MusicPitch(name: .f, accidental: .sharp, octave: 0),
                      MusicPitch(name: .g, accidental: .sharp, octave: 0),
                      MusicPitch(name: .a, accidental: .natural, octave: 0),
                      MusicPitch(name: .b, accidental: .natural, octave: 0),
                      MusicPitch(name: .c, accidental: .sharp, octave: 1),
                      MusicPitch(name: .d, accidental: .sharp, octave: 1),
                      MusicPitch(name: .e, accidental: .natural, octave: 1)]
        XCTAssert(scale == eMajor)
        
        let down = try! MusicScale(root: root, mode: .major, direction: .down)
        XCTAssert(down == eMajor.reversed())
    }
    
    func testCSharpMajorScale() {
        let root = MusicPitch(name: .c, accidental: .sharp, octave: 0)
        let scale = try! MusicScale(root: root, mode: .major, direction: .up)
        let cSharpMajor = [root,
                      MusicPitch(name: .d, accidental: .sharp, octave: 0),
                      MusicPitch(name: .e, accidental: .sharp, octave: 0),
                      MusicPitch(name: .f, accidental: .sharp, octave: 0),
                      MusicPitch(name: .g, accidental: .sharp, octave: 0),
                      MusicPitch(name: .a, accidental: .sharp, octave: 0),
                      MusicPitch(name: .b, accidental: .sharp, octave: 0),
                      MusicPitch(name: .c, accidental: .sharp, octave: 1)]
        XCTAssert(scale == cSharpMajor)
        
        let down = try! MusicScale(root: root, mode: .major, direction: .down)
        XCTAssert(down == cSharpMajor.reversed())
    }
    
    func testDHarmonicMinorScale() {
        let root = MusicPitch(name: .d, accidental: .natural, octave: 0)
        let scale = try! MusicScale(root: root, mode: .harmonicMinor, direction: .up)
        let dMinor = [root,
                      MusicPitch(name: .e, accidental: .natural, octave: 0),
                      MusicPitch(name: .f, accidental: .natural, octave: 0),
                      MusicPitch(name: .g, accidental: .natural, octave: 0),
                      MusicPitch(name: .a, accidental: .natural, octave: 0),
                      MusicPitch(name: .b, accidental: .flat, octave: 0),
                      MusicPitch(name: .c, accidental: .sharp, octave: 1),
                      MusicPitch(name: .d, accidental: .natural, octave: 1)]
        XCTAssert(scale == dMinor, "\(scale)")
        
        let down = try! MusicScale(root: root, mode: .harmonicMinor, direction: .down)
        XCTAssert(down == dMinor.reversed())
    }
    
    func testCSharpNaturalMinorScale() {
        let root = MusicPitch(name: .c, accidental: .sharp, octave: 0)
        let scale = try! MusicScale(root: root, mode: .naturalMinor, direction: .up)
        let cSharpMinor = [root,
                      MusicPitch(name: .d, accidental: .sharp, octave: 0),
                      MusicPitch(name: .e, accidental: .natural, octave: 0),
                      MusicPitch(name: .f, accidental: .sharp, octave: 0),
                      MusicPitch(name: .g, accidental: .sharp, octave: 0),
                      MusicPitch(name: .a, accidental: .natural, octave: 0),
                      MusicPitch(name: .b, accidental: .natural, octave: 0),
                      MusicPitch(name: .c, accidental: .sharp, octave: 1)]
        XCTAssert(scale == cSharpMinor, "\(scale)")
        
        let down = try! MusicScale(root: root, mode: .naturalMinor, direction: .down)
        XCTAssert(down == cSharpMinor.reversed())
    }
    
    func testCMelodicMinorScale() {
        let root = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let scale = try! MusicScale(root: root, mode: .melodicMinor)
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
        
        let up = try! MusicScale(root: root, mode: .melodicMinor, direction: .up)
        let down = try! MusicScale(root: root, mode: .melodicMinor, direction: .down)
        XCTAssert(up == Array(cMinor[0..<8]))
        XCTAssert(down == Array(cMinor[7..<cMinor.count]))
    }
    
    func testMajorPentatonic() {
        let root = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let scale = try! MusicScale(root: root, mode: .majorPentatonic, direction: .up)
        let cPent = [root,
                    MusicPitch(name: .d, accidental: .natural, octave: 0),
                    MusicPitch(name: .e, accidental: .natural, octave: 0),
                    MusicPitch(name: .g, accidental: .natural, octave: 0),
                    MusicPitch(name: .a, accidental: .natural, octave: 0)]
        XCTAssert(scale == cPent, "\(scale)")
        
        let circle = try! MusicScale(root: root, mode: .majorPentatonic, direction: .circular)
        let cPentCirc = Array<MusicPitch>(cPent[0..<cPent.count-1] + cPent.reversed())
        XCTAssert(circle == cPentCirc, "\(circle)")

    }
}
