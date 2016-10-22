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
    
    var name : MusicStaffViewNoteName = .c
    var length : MusicStaffViewNoteLength = .quarter
    var octave : Int = 4
    var accidental : MusicStaffViewAccidentalType = .none
    
    public required init(name: MusicStaffViewNoteName, accidental: MusicStaffViewAccidentalType, length: MusicStaffViewNoteLength, octave: Int) {
        self.name = name
        self.accidental = accidental
        self.length = length
        self.octave = octave
    }
    
}
