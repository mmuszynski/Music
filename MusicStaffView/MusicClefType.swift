//
//  MusicClefType.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/8/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

///Describes a set of clefs generally used to provide a reference for drawing notes in a musical staff.
///
///The five lines in a musical staff are meaningless without reference to a clef. Over the evolution of western music, clefs organized themselves into three distinct types, the C Clef (most commonly associated with alto and tenor clefs), the G Clef (most commonly associated with treble clef) and the F Clef (most commonly associated with bass clef).
///
///However, these three clefs represent three categories under which most other clefs can be described. These clefs are represented as cases of the enum. Other, more useful clefs are represented as static functions (see `MusicClefType.treble`, `MusicClefType.bass`, etc)
public enum MusicClefType {
//    case treble
//    case alto
//    case tenor
//    case bass
    case cClef(offset: Int)
    case fClef(offset: Int)
    case gClef(offset: Int)
    
    public static var treble: MusicClefType {
        return MusicClefType.gClef(offset: -2)
    }
    
    public static var alto: MusicClefType {
        return MusicClefType.cClef(offset: 0)
    }
    
    public static var tenor: MusicClefType {
        return MusicClefType.cClef(offset: 2)
    }
    
    public static var bass: MusicClefType {
        return MusicClefType.fClef(offset: 2)
    }
    
    var referencePitch: MusicPitch {
        switch self {
        case .gClef(_):
            return MusicPitch.init(name: .g, accidental: .natural, octave: 4)
        case .cClef(_):
            return MusicPitch.init(name: .c, accidental: .natural, octave: 4)
        case .fClef(_):
            return MusicPitch.init(name: .f, accidental: .natural, octave: 3)
        }
    }
    
    ///Computes the pitch for the center line.
    ///
    ///Useful for drawing pitches, as they are offset from the center line a number of places.
    ///
    ///- important: The offset for the clef is opposite the direction of the offset of each note. For example, the treble clef reference pitch is offset two places down from the center line (G4), so the center line pitch is offset two places up from this reference (B4).
    public var centerLinePitch: MusicPitch {
        let clefOffset: Int
        
        switch self {
        case .cClef(let offset), .fClef(let offset), .gClef(let offset):
            clefOffset = offset
        }
        
        return MusicClefType.pitch(from: self.referencePitch, offset: -clefOffset)
    }
    
    ///Calculates a pitch that is offset by a number of staff places from another pitch
    static func pitch(from referencePitch: MusicPitch, offset: Int, accidental: MusicPitchAccidentalType = .none) -> MusicPitch {
        //change the offset such that it is relative to the C in this octave
        let clefOffsetFromOctaveC = referencePitch.name.rawValue
        let cOffset = offset + clefOffsetFromOctaveC
        
        //come up with the appropriate, relative octave
        let relativeOctave = cOffset >= 0 ? cOffset / 7 : (cOffset + 1) / 7 - 1
        
        //come up with the relative offset caused by the note
        let noteOffset = cOffset % 7
        let absoluteOffset = noteOffset < 0 ? 7 + noteOffset : noteOffset
        let newPitchName = MusicPitchName(rawValue: absoluteOffset)!
        let newOct = referencePitch.octave + relativeOctave
        
        return MusicPitch(name: newPitchName, accidental: accidental, octave: newOct)
    }
    
    ///Calculates a pitch that is offset by a number of staff places from the `centerLinePitch` for this clef.
    func pitch(forOffset offset: Int, accidental: MusicPitchAccidentalType = .none) -> MusicPitch {
        return MusicClefType.pitch(from: self.centerLinePitch, offset: offset, accidental: accidental)
    }
    
    ///Calculates the offset for a pitch the current clef
    ///
    ///Since notes need to be draw in the correct place in the y-axis, the offset from a given starting location must be computed. Currently, the zero-offset corresponds to the note one ledger line below the lowest staff line (aka Middle C in Treble Clef).
    ///
    ///The offset for the note specifies an offset from the center of the view, which also represents the center of the staff.
    ///
    ///- parameter name: The name of the note
    ///- parameter octave: The octave of the note
    public func offsetForPitch(named name: MusicPitchName, octave: Int) -> Int {
        let reference = self.centerLinePitch
        let offset = reference.relativeOffset(for: name, octave: octave)
        return offset
    }
    
}
