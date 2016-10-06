//
//  MusicStaffViewNote.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

class MusicStaffViewNote: MusicStaffViewElement {
    
    var name : NoteName = .c
    var length : NoteLength = .quarter
    var octave : Int = 4
    var accidental : AccidentalType = .natural
    
    required init(name: NoteName, accidental: AccidentalType, length: NoteLength, octave: Int) {
        self.name = name
        self.accidental = accidental
        self.length = length
        self.octave = octave
    }
    
}
