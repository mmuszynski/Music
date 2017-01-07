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

public enum MusicClefType {
    case treble
    case alto
    case tenor
    case bass
    case genericCClef(offset: Int)
    case genericFClef(offset: Int)
    case genericGClef(offset: Int)
    
    public var zeroOffsetPitch: MusicPitch {
        switch self {
        case .treble:
            return MusicPitch(name: .b, accidental: .none, octave: 4)
        case .alto:
            return MusicPitch(name: .c, accidental: .none, octave: 4)
        case .tenor:
            return MusicPitch(name: .a, accidental: .none, octave: 3)
        case .bass:
            return MusicPitch(name: .d, accidental: .none, octave: 3)
        case .genericCClef(let offset):
            return MusicClefType.alto.pitch(forOffset: -offset)
        case .genericFClef(let offset):
            return MusicClefType.bass.pitch(forOffset: -offset)
        case .genericGClef(let offset):
            return MusicClefType.treble.pitch(forOffset: -offset)
        }
    }
    
    public func pitch(forOffset offset: Int, accidental: MusicPitchAccidentalType = .none) -> MusicPitch {
        let clefOffsetPitch = self.zeroOffsetPitch
        //change the offset such that it is relative to the C in this octave
        let clefOffsetFromOctaveC = clefOffsetPitch.name.rawValue
        let cOffset = offset + clefOffsetFromOctaveC
        
        //come up with the appropriate, relative octave
        let relativeOctave = cOffset >= 0 ? cOffset / 7 : cOffset / 8 - 1
        
        //come up with the relative offset caused by the note
        let noteOffset = cOffset % 7
        let absoluteOffset = noteOffset < 0 ? 7 + noteOffset : noteOffset
        let newPitchName = MusicPitchName(rawValue: absoluteOffset)!
        let newOct = clefOffsetPitch.octave + relativeOctave
        
        return MusicPitch(name: newPitchName, accidental: accidental, octave: newOct)
    }
    
}

enum NoteFlagDirection {
    case up
    case down
}

public class MusicStaffViewElement: NSObject {
   
}
