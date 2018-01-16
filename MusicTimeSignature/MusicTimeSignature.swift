//
//  MusicTimeSignature.swift
//  Music
//
//  Created by Mike Muszynski on 1/14/18.
//  Copyright © 2018 Mike Muszynski. All rights reserved.
//

import Foundation

struct MusicTimeSignature {
    var beats: Int
    var baseRhythm: MusicRhythm
    
    static var common: MusicTimeSignature {
        return MusicTimeSignature(beats: 4, baseRhythm: .quarter)
    }
    
    static var cut: MusicTimeSignature {
        return MusicTimeSignature(beats: 2, baseRhythm: .half)
    }
}
