//
//  MusicRhythm.swift
//  Music
//
//  Created by Mike Muszynski on 4/7/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicRhythm {
    case breve, whole, half, quarter, eighth, sixteenth, thirtysecond, sixtyfourth
    case semibreve, minim, crotchet, quaver, semiquaver, demisemiquaver, hemidemisemiquaver
    indirect case dotted(length: MusicRhythm)
    
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
        default:
            return duration(of: self, withDots: 0)
        }
    }
    
    private func duration(of base: MusicRhythm, withDots dots: Int) -> Int {
        if case .dotted(let inner) = base {
            return self.duration(of: inner, withDots: dots + 1)
        } else {
            let power = Int(pow(2.0, Double(dots)))
            return 2 * base.duration - base.duration / power
        }
    }
}

extension MusicRhythm: Equatable {
    public static func ==(lhs: MusicRhythm, rhs: MusicRhythm) -> Bool {
        return lhs.duration == rhs.duration
    }
}

extension MusicRhythm: Hashable {
    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    public var hashValue: Int {
        return self.duration
    }
}
