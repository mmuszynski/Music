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
    
    public var pitch: MusicPitch
    public var length : MusicNoteLength = .quarter
    
    public required init(name: MusicPitchName, accidental: MusicPitchAccidentalType, length: MusicNoteLength, octave: Int) {
        self.pitch = MusicPitch(name: name, accidental: accidental, octave: octave)
        self.length = length
    }
    
    func isEquivalent(to note: MusicNote) -> Bool {
        if self.pitch != note.pitch {
            return false
        } else if self.length != note.length {
            return false
        }
        
        return true
    }
    
    private var _enharmonicEquivalents = Set<MusicNote>()
    var enharmonicEquivalents: Set<MusicNote> {
        if _enharmonicEquivalents.count == 0 {
            
        }
        return _enharmonicEquivalents
    }
    
    //Hashable
    public var hashValue: Int {
        return self.pitch.hashValue ^ self.length.hashValue
    }
    
    //Equatable
    public static func ==(lhs: MusicNote, rhs: MusicNote) -> Bool {
        return lhs.isEquivalent(to: rhs)
    }
    
}

