//
//  MusicNote.swift
//  MusicNote
//
//  Created by Mike Muszynski on 12/20/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

public struct MusicNote {
    public var pitch: MusicPitch
    public var rhythm: MusicRhythm = .quarter
    
    public init(pitch: MusicPitch, rhythm: MusicRhythm) {
        self.pitch = pitch
        self.rhythm = rhythm
    }
    
    public init(pitchName: MusicPitchName, accidental: MusicAccidental, octave: Int, rhythm: MusicRhythm) {
        let pitch = MusicPitch(name: pitchName, accidental: accidental, octave: octave)
        self.init(pitch: pitch, rhythm: rhythm)
    }
    
    ///Accidental of the note's pitch.
    public var accidental: MusicAccidental {
        get {
            return self.pitch.accidental
        }
        set {
            self.pitch.accidental = newValue
        }
    }
    
    ///PitchAccidental of the note's pitch. Provides more information than just accidental value, such as location in staff for drawing.
    public var pitchAccidental: MusicPitchAccidental {
        return self.pitch.pitchAccidental
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
}

