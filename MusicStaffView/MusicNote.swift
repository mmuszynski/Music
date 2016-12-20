//
//  MusicNote.swift
//  MusicNote
//
//  Created by Mike Muszynski on 12/20/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicNoteAccidentalType {
    case none
    case flat
    case natural
    case sharp
    case doubleFlat
    case doubleSharp
}

public enum MusicNoteLength {
    case breve
    case whole
    case half
    case quarter
    case eighth
    case sixteenth
    case thirtySecond
    case sixtyFourth
}

public enum MusicNoteName: Int {
    case c = 0, d, e, f, g, a, b
    
    public init?(stringValue: String) {
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
