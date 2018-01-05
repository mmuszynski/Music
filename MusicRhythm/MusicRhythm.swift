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
    indirect case compound(number: Int, duration: MusicRhythm)
    
    /// Duration of the note relative to the sixty-fourth note or hemidemisemiquaver.
    private var baseDuration: Int {
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
        case .compound(_):
            fatalError("Compound Rhythm has no base duration")
        default:
            return baseDuration(of: self, withDots: 0)
        }
    }
    
    public var duration: Double {
        switch self {
        case .compound(let number, let base):
            let duration = base.duration
            return duration / Double(number)
        default:
            return Double(self.baseDuration)
        }
    }
    
    public func duration(relativeTo otherRhythm: MusicRhythm) -> Double {
        return self.duration / otherRhythm.duration
    }
    
    private func baseDuration(of base: MusicRhythm, withDots dots: Int) -> Int {
        if case .dotted(let inner) = base {
            return self.baseDuration(of: inner, withDots: dots + 1)
        } else {
            let power = Int(pow(2.0, Double(dots)))
            return 2 * base.baseDuration - base.baseDuration / power
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
        return self.duration.hashValue
    }
}

extension MusicRhythm: CustomStringConvertible {
    public var description: String {
        switch self {
        case .breve:
            return "Breve"
        case .whole:
            return "Whole"
        case .half:
            return "Half"
        case .quarter:
            return "Quarter"
        case .eighth:
            return "Eighth"
        case .sixteenth:
            return "Sixteenth"
        case .thirtysecond:
            return "Thirty-second"
        case .sixtyfourth:
            return "Sixty-fourth"
        case .semibreve:
            return "Semibreve"
        case .minim:
            return "Minim"
        case .crotchet:
            return "Crotchet"
        case .quaver:
            return "Quaver"
        case .semiquaver:
            return "Semiquaver"
        case .demisemiquaver:
            return "Demisemiquaver"
        case .hemidemisemiquaver:
            return "Hemidemisemiquaver"
        case .dotted(let length):
            return "Dotted" + length.description
        case .compound(let number, let duration):
            return "Compound: " + "\(number)" + " in " + duration.description
        }
    }
}

