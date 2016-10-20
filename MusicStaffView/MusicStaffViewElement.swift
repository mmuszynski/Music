//
//  MusicStaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

enum StaffViewElementType {
    case clef(MusicStaffViewClefType)
    case note(MusicStaffViewNoteName, MusicStaffViewAccidentalType, MusicStaffViewNoteLength)
    case accidental(MusicStaffViewAccidentalType)
    case none
}

public enum MusicStaffViewClefType {
    case treble
    case alto
    case tenor
    case bass
    case genericCCleft(offset: Int)
    case genericFClef(offset: Int)
    case genericGClef(offset: Int)
}

public enum MusicStaffViewAccidentalType {
    case none
    case flat
    case natural
    case sharp
    case doubleFlat
    case doubleSharp
}

public enum MusicStaffViewNoteLength {
    case breve
    case whole
    case half
    case quarter
    case eighth
    case sixteenth
    case thirtySecond
    case sixtyFourth
}

public enum MusicStaffViewNoteName: Int {
    case c = 0, d, e, f, g, a, b
    
    init?(stringValue: String) {
        switch stringValue {
        case "A", "a":
            self = .a
        case "B", "b":
            self = .b
        case "C", "c":
            self = .c
        case "D", "d":
            self = .d
        case "E", "e":
            self = .e
        case "F", "f":
            self = .f
        case "G", "g":
            self = .g
        default:
            return nil
        }
    }
}

enum NoteFlagDirection {
    case up
    case down
}

public class MusicStaffViewElement: NSObject {
   
}
