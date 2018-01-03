//
//  MusicPitch.swift
//  Music
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
public struct MusicPitch: Hashable, Comparable, CustomDebugStringConvertible {
   
    ///The `MusicPitchName` representing the name of the pitch
    public var name: MusicPitchName = .c
    
    ///The `MusicAccidental` representing the accidental modifier of the pitch
    public var accidental: MusicAccidental = .natural
    
    ///The `MusicPitchAccidental` representing the accidental enum and the pitch information itself
    public var pitchAccidental: MusicPitchAccidental {
        return MusicPitchAccidental(name: self.name, accidental: self.accidental)
    }
    
    ///The octave of the pitch
    public var octave: Int = 0
    
    ///Integer based index representing number of semitones from the reference pitch C0.
    public var enharmonicIndex: Int {
        return octave * 12 + accidental.enharmonicModifier + name.enharmonicModifier
    }
    
    ///Standard initializer, rearranged to fit the way pitches are described.
    public init(name: MusicPitchName, accidental: MusicAccidental, octave: Int) {
        self.name = name
        self.accidental = accidental
        self.octave = octave
    }
    
    ///Natural language initializer. Given a string, such as "A0", try to create a `MusicPitch` that represents that string.
    ///
    ///Current options:
    ///
    /// - flat: "b"
    /// - sharp: "#"
    /// - doubleFlat: "bb"
    /// - doubleSharp: "x" or "X" or "##"
    /// - There is currently no way to represent naturals and the initializer will default to `MusicAccidental.none`.
    public init?(string: String) {
        guard let name = string.first, let pitchName = MusicPitchName(stringValue: String(name)) else {
            return nil
        }
        
        var accidental: MusicAccidental
        if string.contains("x") || string.contains("X") || string.contains("##") {
            accidental = .doubleSharp
        } else if string.contains("bb") {
            accidental = .doubleFlat
        } else if string.contains("#") {
            accidental = .sharp
        } else if string.contains("b") {
            accidental = .flat
        } else {
            accidental = .none
        }
        
        guard let octave = string.last, let octaveInt = Int(String(octave)) else {
            return nil
        }
        
        self = MusicPitch(name: pitchName, accidental: accidental, octave: octaveInt)
    }
    
    ///Initializer from `enharmonicIndex` and `accidental`.
    ///
    ///Computes `octave` and `name` properties.
    ///
    ///- Warning: This method will return `nil` if the enharmonic cannot be spelled with the provided accidental type.
    public init?(enharmonicIndex: Int, accidental: MusicAccidental) {
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
    
    ///Initializer from `enharmonicIndex` and `name`.
    ///
    ///Computes `octave` and `accidental` properties.
    ///
    ///- Warning: This method will return `nil` if the enharmonic cannot be spelled with the provided name.
    public init?(enharmonicIndex: Int, name: MusicPitchName) {
        //here's a dumb way of doing this. make all the potential notes possible with each of the accidental types
        let accidentals: [MusicAccidental] = [.doubleFlat, .flat, .natural, .sharp, .doubleSharp]
        let potentials = accidentals.flatMap { MusicPitch(enharmonicIndex: enharmonicIndex, accidental: $0) }
        guard let correct = potentials.filter({ $0.name == name }).last else {
            return nil
        }
        
        self = correct
    }
    
    ///Generates all enharmonics of the given pitch.
    ///
    ///
    public func allEnharmonics() -> Set<MusicPitch> {
        let accidentals: [MusicAccidental] = [.doubleFlat, .doubleSharp, .flat, .natural, .sharp]
        let accidentalSet = Set<MusicAccidental>(accidentals)
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
    ///   - name: The `MusicPitchName` to compare to the current `MusicPitch`. If nil, this computes the distance to C0.
    public func relativeOffset(for pitch: MusicPitch? = nil) -> Int {
        var pitch = pitch
        if pitch == nil {
            pitch = MusicPitch(enharmonicIndex: 0, accidental: .none)
        }
        
        let finalPitch = pitch!.name.rawValue
        let finalOctave = pitch!.octave
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
    
    ///A more easily readable version of the description
    public var debugDescription: String {
        let name = self.name.debugDescription
        let accidentalName = self.accidental.debugDescription
        let octaveName = "\(self.octave)"
        return name + accidentalName + octaveName
    }
}
