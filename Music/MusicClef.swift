//
//  MusicClef.swift
//  Music
//
//  Created by Mike Muszynski on 1/8/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

///Describes a set of clefs generally used to provide a reference for drawing notes in a musical staff.
///
///The five lines in a musical staff are meaningless without reference to a clef. Over the evolution of western music, clefs organized themselves into three distinct types, the C Clef (most commonly associated with alto and tenor clefs), the G Clef (most commonly associated with treble clef) and the F Clef (most commonly associated with bass clef).
///
///However, these three clefs represent three categories under which most other clefs can be described. These clefs are represented as cases of the enum. Other, more useful clefs are represented as static functions (see `MusicClef.treble`, `MusicClef.bass`, etc)
public enum MusicClef {
    case cClef(offset: Int)
    case fClef(offset: Int)
    case gClef(offset: Int)
    
    public static var treble: MusicClef {
        return MusicClef.gClef(offset: -2)
    }
    
    public static var alto: MusicClef {
        return MusicClef.cClef(offset: 0)
    }
    
    public static var tenor: MusicClef {
        return MusicClef.cClef(offset: 2)
    }
    
    public static var bass: MusicClef {
        return MusicClef.fClef(offset: 2)
    }
    
    public var referencePitch: MusicPitch {
        switch self {
        case .gClef(_):
            return MusicPitch.init(name: .g, accidental: .natural, octave: 4)
        case .cClef(_):
            return MusicPitch.init(name: .c, accidental: .natural, octave: 4)
        case .fClef(_):
            return MusicPitch.init(name: .f, accidental: .natural, octave: 3)
        }
    }
    
}
