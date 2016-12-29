//
//  MusicStaffViewNote.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

public func +(lhs: MusicStaffViewNote, rhs: Int) -> MusicStaffViewNote {
    return lhs
}

public class MusicStaffViewNote: MusicStaffViewElement {
    
    public var name : MusicPitchName = .c
    public var length : MusicNoteLength = .quarter
    public var octave : Int = 4
    public var accidental : MusicPitchAccidentalType = .none
    
    public required init(name: MusicPitchName, accidental: MusicPitchAccidentalType, length: MusicNoteLength, octave: Int) {
        self.name = name
        self.accidental = accidental
        self.length = length
        self.octave = octave
    }
    
    fileprivate func advanced(by: Int) -> MusicStaffViewNote {
        var advancedNote = MusicStaffViewNote(name: self.name, accidental: self.accidental, length: self.length, octave: self.octave)
        
        
        return advancedNote
    }
    
}
