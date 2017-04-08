//
//  MusicRhythmLength.swift
//  Music
//
//  Created by Mike Muszynski on 4/7/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

enum MusicRhythmLength {
    case breve, whole, half, quarter, eighth, sixteenth, thirtysecond, sixtyfourth
    case semibreve, minim, crotchet, quaver, semiquaver, demisemiquaver, hemidemisemiquaver
    indirect case dotted(length: MusicRhythmLength)
    
    /// Duration of the note relative to the sixty-fourth note or hemidemisemiquaver.
    var duration: Int {
        switch self {
        case .breve:
            return 128
        case .whole, .semibreve:
            return 64
        case .half, .minim:
            return 32
        case .quarter, .crotchet:
            return 16
        case .eighth, .quaver:
            return 8
        case .sixteenth, .semiquaver:
            return 4
        case .thirtysecond, .demisemiquaver:
            return 2
        case .sixtyfourth, .hemidemisemiquaver:
            return 1
        case .dotted(let length):
            let duration = length.duration
            return duration + duration / 2
        }
    }
}
