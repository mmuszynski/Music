//
//  MusicPitch.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 12/29/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

infix operator ~==: ComparisonPrecedence

///MusicPitch is the fundamental discrete unit for naming and displaying musical frequencies.
///
///While frequency is the fundamental quality that determines what a pitch will sound like, MusicPitch describes the discrete units used in Western music used to name and reproduce notes of certain frequencies. In Western music, there are generally assumed to be twelve discrete, named semitones which comprise an interval span called an octave.
///
///In many cases, a pitch can be described by more than one name. In this case, these pitches are considered 'enharmonically equivalent' (although their frequencies will be different, for more, see `frequency(with referencePitch: at frequency:)`).
///
///
public struct MusicPitch: Hashable {
   
    public var name: MusicPitchName = .c
    public var accidental: MusicPitchAccidentalType = .natural
    public var octave: Int = 0
    public var enharmonicIndex: Int {
        return octave * 8 + accidental.modifier() + name.modifier()
    }
    
    public init(name: MusicPitchName, accidental: MusicPitchAccidentalType, octave: Int) {
        self.name = name
        self.accidental = accidental
        self.octave = octave
    }
    
    public static func ==(lhs: MusicPitch, rhs: MusicPitch) -> Bool {
        if lhs.name != rhs.name {
            return false
        } else if rhs.octave != lhs.octave {
            return false
        } else if rhs.accidental != lhs.accidental {
            return false
        }
        
        return true
    }
    
    public var hashValue: Int {
        return enharmonicIndex.hashValue ^ name.hashValue ^ accidental.hashValue
    }
    
    static func ~==(lhs: MusicPitch, rhs: MusicPitch) -> Bool {
        return lhs.enharmonicIndex == rhs.enharmonicIndex
    }
    
    public func isEnharmonicEquivalent(of pitch: MusicPitch) -> Bool {
        return self ~== pitch
    }
}

public enum MusicPitchName: Int {
    case c = 0, d, e, f, g, a, b
    
    func modifier() -> Int {
        return self.rawValue * 2 - (self.rawValue * 2 >= 5 ? 1 : 0)
    }
    
    public init?(stringValue: String) {
        switch stringValue {
        case "A", "a", "la", "La":
            self = .a
        case "B", "b":
            self = .b
        case "C", "c":
            self = .c
        case "D", "d":
            self = .d
        case "E", "e":
            self = .e
        case "F", "f":
            self = .f
        case "G", "g":
            self = .g
        default:
            return nil
        }
    }
}

public enum MusicPitchAccidentalType {
    case none
    case flat
    case natural
    case sharp
    case doubleFlat
    case doubleSharp
    
    func modifier() -> Int {
        switch self {
        case .none, .natural:
            return 0
        case .flat:
            return -1
        case .doubleFlat:
            return -2
        case .sharp:
            return 1
        case .doubleSharp:
            return 2
        }
    }
}
