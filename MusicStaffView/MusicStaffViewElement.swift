//
//  MusicStaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

public enum MusicStaffViewElementType {
    case clef(MusicStaffViewClefType)
    case note(MusicNoteName, MusicNoteAccidentalType, MusicNoteLength)
    case accidental(MusicNoteAccidentalType)
    case none
}

public enum MusicStaffViewClefType {
    case treble
    case alto
    case tenor
    case bass
    case genericCClef(offset: Int)
    case genericFClef(offset: Int)
    case genericGClef(offset: Int)
    
    public var zeroOffsetNote: MusicStaffViewNote {
        switch self {
        case .treble:
            return MusicStaffViewNote(name: .b, accidental: .none, length: .quarter, octave: 4)
        case .alto:
            return MusicStaffViewNote(name: .c, accidental: .none, length: .quarter, octave: 4)
        case .tenor:
            return MusicStaffViewNote(name: .a, accidental: .none, length: .quarter, octave: 3)
        case .bass:
            return MusicStaffViewNote(name: .d, accidental: .none, length: .quarter, octave: 3)
        case .genericCClef(let offset):
            fatalError()
        case .genericFClef(let offset):
            fatalError()
        case .genericGClef(let offset):
            fatalError()
        }
    }
    
}

enum NoteFlagDirection {
    case up
    case down
}

public class MusicStaffViewElement: NSObject {
   
}
