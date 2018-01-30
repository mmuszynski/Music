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
    indirect case dotted(_: MusicRhythm, dots: Int)
    indirect case compound(number: Int, duration: MusicRhythm)
    
    static var crotchet: MusicRhythm {
        return .quarter
    }
    
    static var quaver: MusicRhythm {
        return .eighth
    }
    
    static var semiquaver: MusicRhythm {
        return .sixteenth
    }
    
    static var demisemiquaver: MusicRhythm {
        return .thirtysecond
    }
    
    static var hemidemisemiquaver: MusicRhythm {
        return .sixtyfourth
    }
    
    static var minim: MusicRhythm {
        return .half
    }
    
    static var semibreve: MusicRhythm {
        return .whole
    }
    
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
        case .dotted(_):
            fatalError("Dotted Rhythm has no base duration")
        }
    }
    
    public var duration: Double {
        switch self {
        case .compound(let number, let base):
            let duration = base.duration
            return duration / Double(number)
        case .dotted(let base, let dots):
            let power = Int(pow(2.0, Double(dots)))
            return Double(2 * base.baseDuration - base.baseDuration / power)
        default:
            return Double(self.baseDuration)
        }
    }
    
    public func duration(relativeTo otherRhythm: MusicRhythm) -> Double {
        return self.duration / otherRhythm.duration
    }
    
    public init?(baseDuration: Int) {
        switch baseDuration {
        case 1:
            self = .sixtyfourth
        case 2:
            self = .thirtysecond
        case 4:
            self = .sixteenth
        case 8:
            self = .eighth
        case 16:
            self = .quarter
        case 32:
            self = .half
        case 64:
            self = .whole
        case 128:
            self = .breve
        default:
            return nil
        }
    }
    
}

extension MusicRhythm: Equatable {
    public static func ==(lhs: MusicRhythm, rhs: MusicRhythm) -> Bool {
        switch (lhs, rhs) {
        case (let .dotted(lhsBase, lhsDots), let .dotted(rhsBase, rhsDots)):
            return lhsBase == rhsBase && lhsDots == rhsDots
        case (let .compound(lhNumber, lhDuration), let .compound(rhsNumber, rhsDuration)):
            return lhNumber == rhsNumber && lhDuration == rhsDuration
        case (.whole, .whole), (.half, .half), (.quarter, .quarter), (.eighth, .eighth), (.sixteenth, .sixteenth), (.thirtysecond, .thirtysecond), (.sixtyfourth, .sixtyfourth):
            return true
        default:
            return false
        }
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
        case .dotted(let length, let dots):
            return "\(dots)x Dotted" + length.description
        case .compound(let number, let duration):
            return "Compound: " + "\(number)" + " in " + duration.description
        }
    }
}
