//
//  MusicNote.swift
//  MusicNote
//
//  Created by Mike Muszynski on 12/20/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

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

public class MusicNote: Hashable {
    
    public var name : MusicNoteName = .c
    public var length : MusicNoteLength = .quarter
    public var octave : Int = 4
    public var accidental : MusicNoteAccidentalType = .none
    public var index : Int {
        return octave * 12 + name.rawValue + accidental.modifier()
    }
    
    public required init(name: MusicNoteName, accidental: MusicNoteAccidentalType, length: MusicNoteLength, octave: Int) {
        self.name = name
        self.accidental = accidental
        self.length = length
        self.octave = octave
    }
    
    func isEquivalentTo(note: MusicNote) -> Bool {
        return false
    }
    
    private var _enharmonicEquivalents = Set<MusicNote>()
    var enharmonicEquivalents: Set<MusicNote> {
        if _enharmonicEquivalents.count == 0 {
            
        }
        return _enharmonicEquivalents
    }
    
    //Hashable
    public var hashValue: Int {
        return index.hashValue ^ name.hashValue ^ length.hashValue
    }
    
    public static func ==(lhs: MusicNote, rhs: MusicNote) -> Bool {
        if lhs.name != rhs.name {
            return false
        } else if rhs.length != lhs.length {
            return false
        } else if rhs.octave != lhs.octave {
            return false
        } else if rhs.accidental != lhs.accidental {
            return false
        }
        
        return true
    }
    
}

