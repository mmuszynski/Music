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
    
    static let c: MusicPitch = .init(name: .c)
    static let d: MusicPitch = .init(name: .d)
    static let e: MusicPitch = .init(name: .e)
    static let f: MusicPitch = .init(name: .f)
    static let g: MusicPitch = .init(name: .g)
    static let a: MusicPitch = .init(name: .a)
    static let b: MusicPitch = .init(name: .b)
    
    func accidental(_ accidental: MusicAccidental) -> MusicPitch {
        var returnSelf = self
        returnSelf.accidental = accidental
        return returnSelf
    }
    
    func octave(_ octave: Int) -> MusicPitch {
        var returnSelf = self
        returnSelf.octave = octave
        return returnSelf
    }
    
    func length(_ length: MusicRhythm) -> MusicNote {
        MusicNote(pitch: self, rhythm: length)
    }
}
