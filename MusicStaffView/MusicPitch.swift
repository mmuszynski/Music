//
//  MusicPitch.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 12/29/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

infix operator ~==: ComparisonPrecedence

///MusicPitch is the fundamental discrete unit for naming and displaying musical frequencies.
///
///While frequency is the fundamental quality that determines what a pitch will sound like, MusicPitch describes the discrete units used in Western music used to name and reproduce notes of certain frequencies. In Western music, there are generally assumed to be twelve discrete, named semitones which comprise an interval span called an octave.
///
///In many cases, a pitch can be described by more than one name. In this case, these pitches are considered 'enharmonically equivalent' (although their frequencies will be different, for more, see `frequency(with referencePitch: at frequency:)`).
///
///
public struct MusicPitch: Hashable, Comparable {
   
    ///The `MusicPitchName` representing the name of the pitch
    public var name: MusicPitchName = .c
    
    ///The `MusicPitchAccidentalType` representing the accidental modifier of the pitch
    public var accidental: MusicPitchAccidentalType = .natural
    
    ///The octave of the pitch
    public var octave: Int = 0
    
    ///Integer based index representing number of semitones from the reference pitch C0.
    public var enharmonicIndex: Int {
        return octave * 12 + accidental.enharmonicModifier + name.enharmonicModifier
    }
    
    ///Standard initializer, rearranged to fit the way pitches are described.
    public init(name: MusicPitchName, accidental: MusicPitchAccidentalType, octave: Int) {
        self.name = name
        self.accidental = accidental
        self.octave = octave
    }
    
    ///Initializer from `enharmonicIndex` and `accidental`.
    ///
    ///Computes `octave` and `name` properties.
    ///
    ///- Warning: This method will return `nil` if the enharmonic cannot be spelled with the provided accidental type.
    public init?(enharmonicIndex: Int, accidental: MusicPitchAccidentalType) {
        //the octave will give a range of 12 half-steps
        //the accidental adds or subtracts from there
        //the name is the final piece of the puzzle
        var octave = enharmonicIndex / 12
        var difference = enharmonicIndex - octave * 12 - accidental.enharmonicModifier
        if difference > 11 {
            octave += 1
            difference -= 12
        } else if difference < 0 {
            octave -= 1
            difference += 12
        }
        guard let pitchName = MusicPitchName(enharmonicModifier: difference) else {
            return nil
        }
        
        self = MusicPitch(name: pitchName, accidental: accidental, octave: octave)
    }
    
    ///Generates all enharmonics of the given pitch.
    ///
    ///
    public func allEnharmonics() -> Set<MusicPitch> {
        let accidentals: [MusicPitchAccidentalType] = [.doubleFlat, .doubleSharp, .flat, .natural, .sharp]
        let accidentalSet = Set<MusicPitchAccidentalType>(accidentals)
        let ei = self.enharmonicIndex
        var enharmonics = accidentalSet.flatMap { MusicPitch(enharmonicIndex: ei, accidental: $0) }
        enharmonics.append(self)
        return Set<MusicPitch>(enharmonics)
    }
    
    ///Calculates the relative distance between this pitch and a second when drawn on a staff.
    ///
    ///This method calculates the relative distance between the current note and a second note when drawn on a staff. Since pitch names determine their position on the staff, the most obvious usage involves calculating the place to draw a note with a given name and octave against the reference pitch of a clef.
    ///
    /// - note:
    ///  This is a convenience wrapper for `relativeOffset(for:MusicPitch)`
    ///
    /// - Parameters:
    ///   - name: The `MusicPitch` to compare to the current `MusicPitch`
    ///   - octave: The octave of the second pitch.
    public func relativeOffset(for name: MusicPitchName, octave: Int) -> Int {
        return self.relativeOffset(for: MusicPitch(name: name, accidental: .none, octave: octave));
    }
    
    ///Calculates the relative distance between this pitch and a second when drawn on a staff.
    ///
    ///This method calculates the relative distance between the current note and a second note when drawn on a staff. Since pitch names determine their position on the staff, the most obvious usage involves calculating the place to draw a note with a given name and octave against the reference pitch of a clef.
    ///
    /// - Parameters:
    ///   - name: The `MusicPitchName` to compare to the current `MusicPitch`
    ///   - octave: The octave of the second pitch.
    public func relativeOffset(for pitch: MusicPitch) -> Int {
        let finalPitch = pitch.name.rawValue
        let finalOctave = pitch.octave
        let initialPitch = self.name.rawValue
        let initialOctave = self.octave
                
        return 7 * (finalOctave - initialOctave) + finalPitch - initialPitch
    }

    public static func ==(lhs: MusicPitch, rhs: MusicPitch) -> Bool {
        if lhs.name != rhs.name {
            return false
        } else if rhs.octave != lhs.octave {
            return false
        } else if rhs.accidental != lhs.accidental {
            return false
        }
        
        return true
    }
    
    public var hashValue: Int {
        return enharmonicIndex.hashValue ^ name.hashValue ^ accidental.hashValue
    }
    
    static func ~==(lhs: MusicPitch, rhs: MusicPitch) -> Bool {
        return lhs.enharmonicIndex == rhs.enharmonicIndex
    }
    
    public func isEnharmonicEquivalent(of pitch: MusicPitch) -> Bool {
        return self ~== pitch
    }
    
    
    /// Returns a Boolean value indicating whether the `enharmonicIndex` of the first
    /// pitch is less than that of the second pitch.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A pitch to compare.
    ///   - rhs: Another pitch to compare.
    public static func <(lhs: MusicPitch, rhs: MusicPitch) -> Bool {
        guard lhs.enharmonicIndex != rhs.enharmonicIndex else {
            return lhs.name.enharmonicModifier < rhs.name.enharmonicModifier
        }
        return lhs.enharmonicIndex < rhs.enharmonicIndex
    }
}

public enum MusicPitchName: Int {
    case c = 0, d, e, f, g, a, b
    
    static var allValues: [MusicPitchName] = [.c, .d, .e, .f, .g, .a, .b]
    static var allModifiers: [Int] = {
        return allValues.map { $0.enharmonicModifier }
    }()
    
    var enharmonicModifier: Int {
        return self.rawValue * 2 - (self.rawValue * 2 >= 5 ? 1 : 0)
    }
    
    ///Attempts to initialize a `MusicPitchName` from a string value (e.g. "A", "b", "do", "Re", etc)
    public init?(stringValue: String) {
        switch stringValue.lowercased() {
        case "a", "la":
            self = .a
        case "b", "ti", "si":
            self = .b
        case "c", "do":
            self = .c
        case "d", "re":
            self = .d
        case "e", "mi":
            self = .e
        case "f", "fa":
            self = .f
        case "g", "so", "sol":
            self = .g
        default:
            return nil
        }
    }
    
    ///Attempts to generate a `MusicPitchName` from an enharmonicModifier integer.
    public init?(enharmonicModifier: Int) {
        guard let index = MusicPitchName.allModifiers.index(of: enharmonicModifier) else {
            return nil
        }
        
        self = MusicPitchName.allValues[index]
    }
}

public enum MusicPitchAccidentalType {
    case none
    case flat
    case natural
    case sharp
    case doubleFlat
    case doubleSharp
    
    var enharmonicModifier: Int {
        switch self {
        case .none, .natural:
            return 0
        case .flat:
            return -1
        case .doubleFlat:
            return -2
        case .sharp:
            return 1
        case .doubleSharp:
            return 2
        }
    }
}
