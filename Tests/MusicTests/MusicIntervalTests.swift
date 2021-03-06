//
//  MusicIntervalTests.swift
//  Music
//
//  Created by Mike Muszynski on 1/3/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import Music

extension MusicPitch {
    fileprivate static var C0: MusicPitch {
        return MusicPitch(name: .c, accidental: .natural, octave: 0)
    }
    fileprivate static var E0: MusicPitch {
        return MusicPitch(name: .e, accidental: .natural, octave: 0)
    }
    
    fileprivate var nextOctave: MusicPitch {
        let octave = try! MusicInterval(direction: .upward, quality: .perfect, quantity: .octave)
        return try! self.transposed(by: octave)
    }
    
    fileprivate static func ..<(lhs: MusicPitch, rhs: MusicPitch) throws -> MusicInterval {
        return try MusicInterval(rootPitch: lhs, destinationPitch: rhs)
    }
}

class MusicIntervalTests: XCTestCase {
    
    func testIntervalsUnisons() {
        //unison
        let C0 = MusicPitch.C0
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
            XCTAssertEqual(diminishedOctave.quality, MusicIntervalQuality.diminished)
            XCTAssertEqual(diminishedOctave.quantity, MusicIntervalQuantity.octave)
        } catch {
            XCTFail("Error should not be generated: \(error)")
        }
        
        do {
            let CDoubleFlat0 = MusicPitch(name: .c, accidental: .doubleFlat, octave: 0)
            let _ = try MusicInterval(rootPitch: C0, destinationPitch: CDoubleFlat0)
            XCTFail("Should throw error")
        } catch MusicIntervalError.InvalidQualityQuantityCombination {

        } catch {
            XCTFail("Should not throw other errors")
        }
        
    }
    
    func testDownwardUnision() {
        let c0 = MusicPitch.C0
        let cb0 = MusicPitch(name: .c, accidental: .flat, octave: 0)
        do {
            let augmentedUnison = try MusicInterval(rootPitch: c0, destinationPitch: cb0)
            XCTAssertEqual(augmentedUnison.halfStepDistance, -1)
            XCTAssertEqual(augmentedUnison.quality, MusicIntervalQuality.augmented)
            XCTAssertEqual(augmentedUnison.quantity, MusicIntervalQuantity.unison)
        } catch {
            XCTFail("interval should be created")
        }
    }
    
    func testIntervalsSeconds() {
        let C0 = MusicPitch.C0
        let D0 = MusicPitch(name: .d, accidental: .natural, octave: 0)
        let Db0 = MusicPitch(name: .d, accidental: .flat, octave: 0)
        let Dsharp0 = MusicPitch(name: .d, accidental: .sharp, octave: 0)
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
            
            XCTAssertEqual(diminishedSecond.quality, MusicIntervalQuality.diminished)
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
    
    func testDownwardSecond() {
        let C0 = MusicPitch.C0
        let D0 = MusicPitch(name: .d, accidental: .natural, octave: 0)
        
        do {
            let majorSecond = try MusicInterval(rootPitch: D0, destinationPitch: C0)
            XCTAssertEqual(majorSecond.halfStepDistance, -2)
            XCTAssertEqual(majorSecond.quality, MusicIntervalQuality.major)
            XCTAssertEqual(majorSecond.quantity, MusicIntervalQuantity.second)
        } catch {
            XCTFail("Error should not be generated: \(error)")
        }
    }
    
    func testThirds() {
        let C0 = MusicPitch.C0
        let Ebb0 = MusicPitch(name: .e, accidental: .doubleFlat, octave: 0)
        let Eb0 = MusicPitch(name: .e, accidental: .flat, octave: 0)
        let E0 = MusicPitch.E0
        let Es0 = MusicPitch(name: .e, accidental: .sharp, octave: 0)
        
        do {
            let major = try MusicInterval(rootPitch: C0, destinationPitch: E0)
            XCTAssertEqual(major.halfStepDistance, 4)
            XCTAssertEqual(major.quality, MusicIntervalQuality.major)
            XCTAssertEqual(major.quantity, MusicIntervalQuantity.third)
            
            let minor = try MusicInterval(rootPitch: C0, destinationPitch: Eb0)
            XCTAssertEqual(minor.halfStepDistance, 3)
            XCTAssertEqual(minor.quality, MusicIntervalQuality.minor)
            XCTAssertEqual(minor.quantity, MusicIntervalQuantity.third)
            
            let diminished = try MusicInterval(rootPitch: C0, destinationPitch: Ebb0)
            XCTAssertEqual(diminished.halfStepDistance, 2)
            XCTAssertEqual(diminished.quality, MusicIntervalQuality.diminished)
            XCTAssertEqual(diminished.quantity, MusicIntervalQuantity.third)
            
            let augmented = try MusicInterval(rootPitch: C0, destinationPitch: Es0)
            XCTAssertEqual(augmented.halfStepDistance, 5)
            XCTAssertEqual(augmented.quality, MusicIntervalQuality.augmented)
            XCTAssertEqual(augmented.quantity, MusicIntervalQuantity.third)
        } catch {
            XCTFail("\(error) should not be generated")
        }
    }
    
    func testFourths() {
        let C0 = MusicPitch.C0
        let F0 = MusicPitch(name: .f, accidental: .natural, octave: 0)
        let Fs0 = MusicPitch(name: .f, accidental: .sharp, octave: 0)
        let Fb0 = MusicPitch(name: .f, accidental: .flat, octave: 0)
        
        do {
            let perfect = try MusicInterval(rootPitch: C0, destinationPitch: F0)
            XCTAssertEqual(perfect.halfStepDistance, 5)
            XCTAssertEqual(perfect.quality, MusicIntervalQuality.perfect)
            XCTAssertEqual(perfect.quantity, MusicIntervalQuantity.fourth)
            
            let diminished = try MusicInterval(rootPitch: C0, destinationPitch: Fb0)
            XCTAssertEqual(diminished.halfStepDistance, 4)
            XCTAssertEqual(diminished.quality, MusicIntervalQuality.diminished)
            XCTAssertEqual(diminished.quantity, MusicIntervalQuantity.fourth)
            
            let augmented = try MusicInterval(rootPitch: C0, destinationPitch: Fs0)
            XCTAssertEqual(augmented.halfStepDistance, 6)
            XCTAssertEqual(augmented.quality, MusicIntervalQuality.augmented)
            XCTAssertEqual(augmented.quantity, MusicIntervalQuantity.fourth)
        } catch {
            XCTFail("\(error) should not be generated")
        }
    }
    
    func testFifths() {
        let C0 = MusicPitch.C0
        let G0 = MusicPitch(name: .g, accidental: .natural, octave: 0)
        let Gs0 = MusicPitch(name: .g, accidental: .sharp, octave: 0)
        let Gb0 = MusicPitch(name: .g, accidental: .flat, octave: 0)
        
        do {
            let perfect = try MusicInterval(rootPitch: C0, destinationPitch: G0)
            XCTAssertEqual(perfect.halfStepDistance, 7)
            XCTAssertEqual(perfect.quality, MusicIntervalQuality.perfect)
            XCTAssertEqual(perfect.quantity, MusicIntervalQuantity.fifth)
            
            let diminished = try MusicInterval(rootPitch: C0, destinationPitch: Gb0)
            XCTAssertEqual(diminished.halfStepDistance, 6)
            XCTAssertEqual(diminished.quality, MusicIntervalQuality.diminished)
            XCTAssertEqual(diminished.quantity, MusicIntervalQuantity.fifth)
            
            let augmented = try MusicInterval(rootPitch: C0, destinationPitch: Gs0)
            XCTAssertEqual(augmented.halfStepDistance, 8)
            XCTAssertEqual(augmented.quality, MusicIntervalQuality.augmented)
            XCTAssertEqual(augmented.quantity, MusicIntervalQuantity.fifth)
        } catch {
            XCTFail("\(error) should not be generated")
        }
    }
    
    func testSixths() {
        let C0 = MusicPitch.C0
        let A0 = MusicPitch(name: .a, accidental: .natural, octave: 0)
        let As0 = MusicPitch(name: .a, accidental: .sharp, octave: 0)
        let Ab0 = MusicPitch(name: .a, accidental: .flat, octave: 0)
        let Abb0 = MusicPitch(name: .a, accidental: .doubleFlat, octave: 0)
        
        do {
            let major = try MusicInterval(rootPitch: C0, destinationPitch: A0)
            XCTAssertEqual(major.halfStepDistance, 9)
            XCTAssertEqual(major.quality, MusicIntervalQuality.major)
            XCTAssertEqual(major.quantity, MusicIntervalQuantity.sixth)
            
            let minor = try MusicInterval(rootPitch: C0, destinationPitch: Ab0)
            XCTAssertEqual(minor.halfStepDistance, 8)
            XCTAssertEqual(minor.quality, MusicIntervalQuality.minor)
            XCTAssertEqual(minor.quantity, MusicIntervalQuantity.sixth)
            
            let diminished = try MusicInterval(rootPitch: C0, destinationPitch: Abb0)
            XCTAssertEqual(diminished.halfStepDistance, 7)
            XCTAssertEqual(diminished.quality, MusicIntervalQuality.diminished)
            XCTAssertEqual(diminished.quantity, MusicIntervalQuantity.sixth)
            
            let augmented = try MusicInterval(rootPitch: C0, destinationPitch: As0)
            XCTAssertEqual(augmented.halfStepDistance, 10)
            XCTAssertEqual(augmented.quality, MusicIntervalQuality.augmented)
            XCTAssertEqual(augmented.quantity, MusicIntervalQuantity.sixth)
        } catch {
            XCTFail("\(error) should not be generated")
        }
    }
    
    func testSevenths() {
        let C0 = MusicPitch.C0
        let B0 = MusicPitch(name: .b, accidental: .natural, octave: 0)
        let Bs0 = MusicPitch(name: .b, accidental: .sharp, octave: 0)
        let Bb0 = MusicPitch(name: .b, accidental: .flat, octave: 0)
        let Bbb0 = MusicPitch(name: .b, accidental: .doubleFlat, octave: 0)
        
        do {
            let major = try MusicInterval(rootPitch: C0, destinationPitch: B0)
            XCTAssertEqual(major.halfStepDistance, 11)
            XCTAssertEqual(major.quality, MusicIntervalQuality.major)
            XCTAssertEqual(major.quantity, MusicIntervalQuantity.seventh)
            
            let minor = try MusicInterval(rootPitch: C0, destinationPitch: Bb0)
            XCTAssertEqual(minor.halfStepDistance, 10)
            XCTAssertEqual(minor.quality, MusicIntervalQuality.minor)
            XCTAssertEqual(minor.quantity, MusicIntervalQuantity.seventh)
            
            let diminished = try MusicInterval(rootPitch: C0, destinationPitch: Bbb0)
            XCTAssertEqual(diminished.halfStepDistance, 9)
            XCTAssertEqual(diminished.quality, MusicIntervalQuality.diminished)
            XCTAssertEqual(diminished.quantity, MusicIntervalQuantity.seventh)
            
            let augmented = try MusicInterval(rootPitch: C0, destinationPitch: Bs0)
            XCTAssertEqual(augmented.halfStepDistance, 12)
            XCTAssertEqual(augmented.quality, MusicIntervalQuality.augmented)
            XCTAssertEqual(augmented.quantity, MusicIntervalQuantity.seventh)
        } catch {
            XCTFail("\(error) should not be generated")
        }
    }
    
    func testOctaves() {
        let C0 = MusicPitch.C0
        let C1 = MusicPitch(name: .c, accidental: .natural, octave: 1)
        let Cs1 = MusicPitch(name: .c, accidental: .sharp, octave: 1)
        let Cb1 = MusicPitch(name: .c, accidental: .flat, octave: 1)
        
        do {
            let perfect = try MusicInterval(rootPitch: C0, destinationPitch: C1)
            XCTAssertEqual(perfect.halfStepDistance, 12)
            XCTAssertEqual(perfect.quality, MusicIntervalQuality.perfect)
            XCTAssertEqual(perfect.quantity, MusicIntervalQuantity.octave)
            
            let diminished = try MusicInterval(rootPitch: C0, destinationPitch: Cb1)
            XCTAssertEqual(diminished.halfStepDistance, 11)
            XCTAssertEqual(diminished.quality, MusicIntervalQuality.diminished)
            XCTAssertEqual(diminished.quantity, MusicIntervalQuantity.octave)
            
            let augmented = try MusicInterval(rootPitch: C0, destinationPitch: Cs1)
            XCTAssertEqual(augmented.halfStepDistance, 13)
            XCTAssertEqual(augmented.quality, MusicIntervalQuality.augmented)
            XCTAssertEqual(augmented.quantity, MusicIntervalQuantity.octave)
        } catch {
            XCTFail("\(error) should not be generated")
        }
    }
    
    func testGenericIntervals() {
        let C0 = MusicPitch.C0
        let C2 = MusicPitch(name: .c, accidental: .natural, octave: 2)
        let Cs2 = MusicPitch(name: .c, accidental: .sharp, octave: 2)
        let Cb2 = MusicPitch(name: .c, accidental: .flat, octave: 2)
        
        do {
            let perfect = try MusicInterval(rootPitch: C0, destinationPitch: C2)
            XCTAssertEqual(perfect.halfStepDistance, 24)
            XCTAssertEqual(perfect.quality, MusicIntervalQuality.perfect)
            XCTAssertEqual(perfect.quantity, MusicIntervalQuantity.compound(octaves: 2, plusQuantity: .unison))
            
            let diminished = try MusicInterval(rootPitch: C0, destinationPitch: Cb2)
            XCTAssertEqual(diminished.halfStepDistance, 23)
            XCTAssertEqual(diminished.quality, MusicIntervalQuality.diminished)
            XCTAssertEqual(perfect.quantity, MusicIntervalQuantity.compound(octaves: 2, plusQuantity: .unison))
            
            let augmented = try MusicInterval(rootPitch: C0, destinationPitch: Cs2)
            XCTAssertEqual(augmented.halfStepDistance, 25)
            XCTAssertEqual(augmented.quality, MusicIntervalQuality.augmented)
            XCTAssertEqual(perfect.quantity, MusicIntervalQuantity.compound(octaves: 2, plusQuantity: .unison))
        } catch {
            XCTFail("\(error) should not be generated")
        }
    }
    
    func testIsPerfectType() {
        XCTAssert(MusicIntervalQuantity.unison.isPerfectType)
        XCTAssert(!MusicIntervalQuantity.second.isPerfectType)
        XCTAssert(!MusicIntervalQuantity.third.isPerfectType)
        XCTAssert(MusicIntervalQuantity.fourth.isPerfectType)
        XCTAssert(MusicIntervalQuantity.fifth.isPerfectType)
        XCTAssert(!MusicIntervalQuantity.sixth.isPerfectType)
        XCTAssert(!MusicIntervalQuantity.seventh.isPerfectType)
        XCTAssert(MusicIntervalQuantity.octave.isPerfectType)
        XCTAssert(MusicIntervalQuantity.compound(octaves: 0, plusQuantity: .fifth).isPerfectType)
        XCTAssert(MusicIntervalQuantity.compound(octaves: 0, plusQuantity: .unison).isPerfectType)
        XCTAssert(MusicIntervalQuantity.compound(octaves: 2, plusQuantity: .fifth).isPerfectType)
        XCTAssert(MusicIntervalQuantity.compound(octaves: 1, plusQuantity: .fifth).isPerfectType)
    }
    
    func testPerformance() {
        
        func createIntervals() {
            let C0 = MusicPitch.C0
            let CSharp0 = MusicPitch(name: .c, accidental: .sharp, octave: 0)
            let _ = try! MusicInterval(rootPitch: C0, destinationPitch: C0)
            let _ = try! MusicInterval(rootPitch: C0, destinationPitch: CSharp0)
        }
        
        self.measure(createIntervals)
    }
    
    func testIntervalFromQualityQuantity() {
        let C0 = MusicPitch.C0
        let D0 = MusicPitch(name: .d, accidental: .natural, octave: 0)
        do {
            let majorSecond = try MusicInterval(direction: .upward, quality: .major, quantity: .second)
            let destination = try majorSecond.destinationPitch(from: C0)
            XCTAssertEqual(destination, D0)
        } catch {
            XCTFail("\(error)")
        }
        
        
        let Eb0 = MusicPitch(name: .e, accidental: .flat, octave: 0)
        do {
            let m3 = try MusicInterval( direction: .upward, quality: .minor, quantity: .third)
            let destination = try m3.destinationPitch(from: C0)

            XCTAssertEqual(destination, Eb0)
        } catch {
            XCTFail("\(error)")
        }
        
        let Ebb0 = MusicPitch(name: .e, accidental: .doubleFlat, octave: 0)
        do {
            let dim3 = try MusicInterval( direction: .upward, quality: .diminished, quantity: .third)
            let destination = try dim3.destinationPitch(from: C0)
            XCTAssertEqual(destination, Ebb0)
        } catch {
            XCTFail("\(error)")
        }
        
        let Eis0 = MusicPitch(name: .e, accidental: .sharp, octave: 0)
        let E0 = MusicPitch.E0
        do {
            let aug3 = try MusicInterval( direction: .upward, quality: .augmented, quantity: .third)
            let destination = try aug3.destinationPitch(from: C0)
            XCTAssertEqual(destination, Eis0)
        } catch {
            XCTFail("\(error)")
        }
        
        let Gx0 = MusicPitch(name: .g, accidental: .doubleSharp, octave: 0)
        do {
            let aug3 = try MusicInterval( direction: .upward, quality: .augmented, quantity: .third)
            let destination = try aug3.destinationPitch(from: E0)

            XCTAssertEqual(destination, Gx0)
        } catch {
            XCTFail("\(error)")
        }
        
        let F0 = MusicPitch(name: .f, accidental: .natural, octave: 0)
        do {
            let P4 = try MusicInterval( direction: .upward, quality: .perfect, quantity: .fourth)
            let destination = try P4.destinationPitch(from: C0)

            XCTAssertEqual(destination, F0)
        } catch {
            XCTFail("\(error)")
        }
        
        let Fis0 = MusicPitch(name: .f, accidental: .sharp, octave: 0)
        do {
            let aug4 = try MusicInterval( direction: .upward, quality: .augmented, quantity: .fourth)
            let destination = try aug4.destinationPitch(from: C0)

            XCTAssertEqual(destination, Fis0)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testPoorlyPairedQualityAndQuantity() {
        do {
            let _ = try MusicInterval(direction: .upward, quality: .perfect, quantity: .third)
            XCTFail()
        } catch MusicIntervalError.InvalidQualityQuantityCombination {
            
        } catch {
            XCTFail("Wrong error \(error)")
        }
    }
    
    func testDestinationPitchesThatShouldNotBeReached() {
        let Dx0 = MusicPitch(name: .d, accidental: .doubleSharp, octave: 0)

        do {
            let badInterval = try MusicInterval( direction: .upward, quality: .major, quantity: .third)
            let _ = try badInterval.destinationPitch(from: Dx0)
            XCTFail("\(badInterval)")
        } catch MusicIntervalError.CouldNotComputeDestniationPitch(quality: let quality, quantity: let quantity, direction: let direction, let rootPitch) {
            XCTAssertEqual(quality, .major)
            XCTAssertEqual(quantity, .third)
            XCTAssertEqual(direction, .upward)
            XCTAssertEqual(rootPitch, Dx0)
        } catch {
            XCTFail("Wrong error \(error)")
        }
    }
    
    func testDirectionOnCreatedInterval() {
        let C0 = MusicPitch.C0
        let Cis0 = MusicPitch(name: .c, accidental: .sharp, octave: 0)
        let upward = try! MusicInterval(rootPitch: C0, destinationPitch: Cis0)
        let downward = try! MusicInterval(rootPitch: Cis0, destinationPitch: C0)
        XCTAssertEqual(upward.direction, .upward)
        XCTAssertEqual(downward.direction, .downward)
    }
    
    func testIntervalInversion() {
        let C0 = MusicPitch.C0
        let E0 = MusicPitch.E0
        let C1 = C0.nextOctave
        let E1 = E0.nextOctave
        
        let majorThird = try! MusicInterval(rootPitch: C0, destinationPitch: E0)
        let minorSixth = try! MusicInterval(rootPitch: E0, destinationPitch: C1)
        var otherMinorSixth = majorThird.inverted
        
        XCTAssertEqual(minorSixth, otherMinorSixth)
        otherMinorSixth.invert()
        XCTAssertEqual(otherMinorSixth, majorThird)
        
        var compound = try! C0..<E1
        compound.invert()
        XCTAssertEqual(minorSixth, compound)
    }
    
    func testReversal() {
        let majorThird = try! MusicPitch.C0..<MusicPitch.E0
        let minorThird = try! MusicPitch.E0..<MusicPitch.C0
        let otherMajorThird = minorThird.reversed
        XCTAssertEqual(majorThird, otherMajorThird)
    }
}
