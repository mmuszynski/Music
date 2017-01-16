//
//  MusicIntervalTests.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/3/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import MusicStaffView

class MusicIntervalTests: XCTestCase {
    
    func testIntervalsUnisons() {
        //unison
        let C0 = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let CSharp0 = MusicPitch(name: .c, accidental: .sharp, octave: 0)
        let Cflat1 = MusicPitch(name: .c, accidental: .flat, octave: 1)

        do {
            let perfectUnison = try MusicInterval(rootPitch: C0, destinationPitch: C0)
            let augmentedUnison = try MusicInterval(rootPitch: C0, destinationPitch: CSharp0)
            let diminishedOctave = try MusicInterval(rootPitch: C0, destinationPitch: Cflat1)
            
            XCTAssertEqual(perfectUnison.halfStepDistance, 0)
            XCTAssertEqual(perfectUnison.quality, MusicIntervalQuality.perfect)
            XCTAssertEqual(perfectUnison.quantity, MusicIntervalQuantity.unison)
            
            XCTAssertEqual(augmentedUnison.halfStepDistance, 1)
            XCTAssertEqual(augmentedUnison.quality, MusicIntervalQuality.augmented)
            XCTAssertEqual(augmentedUnison.quantity, MusicIntervalQuantity.unison)
            
            XCTAssertEqual(diminishedOctave.halfStepDistance, 11)
            XCTAssertEqual(diminishedOctave.quality, MusicIntervalQuality.diminshed)
            XCTAssertEqual(diminishedOctave.quantity, MusicIntervalQuantity.octave)
        } catch {
            XCTFail("Error should not be generated: \(error)")
        }
        
        do {
            let Cflat0 = MusicPitch(name: .c, accidental: .flat, octave: 0)
            let _ = try MusicInterval(rootPitch: C0, destinationPitch: Cflat0)
        } catch {
            XCTAssertEqual(error as! MusicIntervalError, MusicIntervalError.InvalidQuality)
        }
        
        
    }
    
    func testIntervalsSeconds() {
        let C0 = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let D0 = MusicPitch(name: .d, accidental: .natural, octave: 0)
        let Db0 = MusicPitch(name: .d, accidental: .flat, octave: 0)
        let Dsharp0 = MusicPitch(name: .d, accidental: .sharp, octave: 0)
        let DdoubleSharp = MusicPitch(name: .d, accidental: .doubleSharp, octave: 0)
        let DdoubleFlat = MusicPitch(name: .d, accidental: .doubleFlat, octave: 0)
        
        do {
            let majorSecond = try MusicInterval(rootPitch: C0, destinationPitch: D0)
            let minorSecond = try MusicInterval(rootPitch: C0, destinationPitch: Db0)
            let diminishedSecond = try MusicInterval(rootPitch: C0, destinationPitch: DdoubleFlat)
            let augmentedSecond = try MusicInterval(rootPitch: C0, destinationPitch: Dsharp0)
            
            XCTAssertEqual(diminishedSecond.halfStepDistance, 0)
            XCTAssertEqual(minorSecond.halfStepDistance, 1)
            XCTAssertEqual(majorSecond.halfStepDistance, 2)
            XCTAssertEqual(augmentedSecond.halfStepDistance, 3)
            
            XCTAssertEqual(diminishedSecond.quality, MusicIntervalQuality.diminshed)
            XCTAssertEqual(minorSecond.quality, MusicIntervalQuality.minor)
            XCTAssertEqual(majorSecond.quality, MusicIntervalQuality.major)
            XCTAssertEqual(augmentedSecond.quality, MusicIntervalQuality.augmented)
            
            XCTAssertEqual(diminishedSecond.quantity, MusicIntervalQuantity.second)
            XCTAssertEqual(minorSecond.quantity, MusicIntervalQuantity.second)
            XCTAssertEqual(majorSecond.quantity, MusicIntervalQuantity.second)
            XCTAssertEqual(augmentedSecond.quantity, MusicIntervalQuantity.second)


        } catch {
            XCTFail("Error should not be generated: \(error)")
        }
    }
    
}
