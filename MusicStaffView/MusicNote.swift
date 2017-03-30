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
    
    ///Accidental of the note's pitch.
    public var accidental: MusicPitchAccidental {
        get {
            return self.pitch.accidental
        }
        set {
            self.pitch.accidental = newValue
        }
    }
    
    ///Name of the note's pitch
    public var name: MusicPitchName {
        get {
            return self.pitch.name
        }
        set {
            self.pitch.name = newValue
        }
    }
    
    ///Octave of the note's pitch
    public var octave: Int {
        get {
            return self.pitch.octave
        }
        set {
            self.pitch.octave = newValue
        }
    }
    
    public required init(pitch: MusicPitch, length: MusicNoteLength) {
        self.pitch = pitch
        self.length = length
    }
    
    public required init(name: MusicPitchName, accidental: MusicPitchAccidental, length: MusicNoteLength, octave: Int) {
        self.pitch = MusicPitch(name: name, accidental: accidental, octave: octave)
        self.length = length
    }
    
    private func isEquivalent(to note: MusicNote) -> Bool {
        if self.pitch != note.pitch {
            return false
        } else if self.length != note.length {
            return false
        }
        
        return true
    }
    
    private func isEnharmonicallyEquivalent(to otherNote: MusicNote) -> Bool {
        return self.pitch.isEnharmonicEquivalent(of: otherNote.pitch)
    }
    
    //Hashable
    public var hashValue: Int {
        return self.pitch.hashValue ^ self.length.hashValue
    }
    
    //Equatable
    public static func ==(lhs: MusicNote, rhs: MusicNote) -> Bool {
        return lhs.isEquivalent(to: rhs)
    }
    
    //Comparable
    
}

