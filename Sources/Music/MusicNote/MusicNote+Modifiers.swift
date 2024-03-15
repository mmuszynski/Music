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
        MusicPitch(name: self.name, accidental: accidental, octave: self.octave)
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
    public var sharp: Self {
        self.accidental(.sharp)
    }    
    
    //A computed property to set the accidental of the pitch to a natural
    public var natural: Self {
        self.accidental(.natural)
    }
    
    //A computed property to set the accidental of the pitch to a flat
    public var flat: Self {
        self.accidental(.flat)
    }
    
    //A computed property to set the accidental of the pitch to a double flat
    public var doubleFlat: Self {
        self.accidental(.doubleFlat)
    }    
    
    //A computed property to set the accidental of the pitch to a double flat
    public var doubleSharp: Self {
        self.accidental(.doubleSharp)
    }
}

//Properties that make `MusicNote` objects out of `MusicPitch` objects
extension MusicPitch {
    
    public var quarter: MusicNote {
        self.note(with: .quarter)
    }
    
    public var half: MusicNote {
        self.note(with: .half)
    }
    
    public var whole: MusicNote {
        self.note(with: .whole)
    }
    
    public var eighth: MusicNote {
        self.note(with: .eighth)
    }
    
    public var sixteenth: MusicNote {
        self.note(with: .sixteenth)
    }
    
    public var thirtysecond: MusicNote {
        self.note(with: .thirtysecond)
    }
    
    public var sixtyfourth: MusicNote {
        self.note(with: .sixtyfourth)
    }
}
