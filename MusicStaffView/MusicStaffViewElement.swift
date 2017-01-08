//
//  MusicStaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

public enum MusicStaffViewElementType {
    case clef(MusicClefType)
    case note(MusicPitchName, MusicPitchAccidentalType, MusicNoteLength)
    case accidental(MusicPitchAccidentalType)
    case none
}

///Describes the most commonly used clefs, as well as a set of generic clefs centered at a specific pitch.
public enum MusicClefType {
    //case treble
    case alto
    case tenor
    case bass
    case genericCClef(offset: Int)
    case genericFClef(offset: Int)
    case gClef(offset: Int)
    
    public static var treble: MusicClefType {
        return MusicClefType.gClef(offset: -2)
    }
    
    var referencePitch: MusicPitch {
        switch self {
        case .gClef(_):
            return MusicPitch.init(name: .g, accidental: .natural, octave: 4)
        case .alto, .tenor, .genericCClef(_):
            return MusicPitch.init(name: .c, accidental: .natural, octave: 4)
        case .bass, .genericFClef(_):
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
        case .alto:
            clefOffset = 0
        case .tenor:
            clefOffset = 2
        case .bass:
            clefOffset = 2
        case .genericCClef(let offset), .genericFClef(let offset), .gClef(let offset):
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

enum NoteFlagDirection {
    case up
    case down
}

public class MusicStaffViewElement: NSObject {
   
}
