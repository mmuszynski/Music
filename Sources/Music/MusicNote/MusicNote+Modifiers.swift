//
//  File.swift
//  
//
//  Created by Mike Muszynski on 6/19/23.
//

import Foundation

extension MusicPitch {
    fileprivate init(name: MusicPitchName, octave: Int = 4) {
        self = .init(name: name, accidental: .natural, octave: octave)
    }
    
    public static let c: MusicPitch = .init(name: .c)
    public static let d: MusicPitch = .init(name: .d)
    public static let e: MusicPitch = .init(name: .e)
    public static let f: MusicPitch = .init(name: .f)
    public static let g: MusicPitch = .init(name: .g)
    public static let a: MusicPitch = .init(name: .a)
    public static let b: MusicPitch = .init(name: .b)
    
    public func accidental(_ accidental: MusicAccidental) -> MusicPitch {
        var returnSelf = self
        returnSelf.accidental = accidental
        return returnSelf
    }
    
    public func octave(_ octave: Int) -> MusicPitch {
        var returnSelf = self
        returnSelf.octave = octave
        return returnSelf
    }
    
    public func length(_ length: MusicRhythm) -> MusicNote {
        MusicNote(pitch: self, rhythm: length)
    }
    
    //A computed property to set the accidental of the pitch to a sharp
    var sharp: Self {
        self.accidental(.sharp)
    }    
    
    //A computed property to set the accidental of the pitch to a natural
    var natural: Self {
        self.accidental(.natural)
    }
    
    //A computed property to set the accidental of the pitch to a flat
    var flat: Self {
        self.accidental(.flat)
    }
    
    //A computed property to set the accidental of the pitch to a double flat
    var doubleFlat: Self {
        self.accidental(.doubleFlat)
    }    
    
    //A computed property to set the accidental of the pitch to a double flat
    var doubleSharp: Self {
        self.accidental(.doubleSharp)
    }
}
