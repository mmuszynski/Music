//
//  MusicPitchName.swift
//  Music
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

/// The name used to describe a musical pitch, describing its place on the staff.
public enum MusicPitchName: Int, CustomDebugStringConvertible {
    case c = 0, d, e, f, g, a, b
    
    /// All values of the enum, suitable for enumeration
    static var allValues: [MusicPitchName] = [.c, .d, .e, .f, .g, .a, .b]
    
    /// All `enharmonicModifier` values, suitable for enumeration and useful for computing a pitch in many circumstances. Lazily evaluated.
    static var allModifiers: [Int] = {
        return allValues.map { $0.enharmonicModifier }
    }()
    

    /// The enharmonic modifier for a specific `MusicPitchName`, meaning the number of half steps the name raises from `c`.
    var enharmonicModifier: Int {
        return self.rawValue * 2 - (self.rawValue * 2 >= 5 ? 1 : 0)
    }
    
    ///Attempts to initialize a `MusicPitchName` from a string value (e.g. "A", "b", "do", "Re", etc)
    public init?(string: String) {
        switch string.lowercased() {
        case "a", "la":
            self = .a
        case "b", "ti", "si":
            self = .b
        case "c", "do":
            self = .c
        case "d", "re":
            self = .d
        case "e", "mi":
            self = .e
        case "f", "fa":
            self = .f
        case "g", "so", "sol":
            self = .g
        default:
            return nil
        }
    }
    
    ///Attempts to generate a `MusicPitchName` from an enharmonicModifier integer.
    public init?(enharmonicModifier: Int) {
        guard let index = MusicPitchName.allModifiers.index(of: enharmonicModifier) else {
            return nil
        }
        
        self = MusicPitchName.allValues[index]
    }
    
    ///Gives the name of a note offset by a given number of spaces on the staff
    public func offset(by offset: Int) -> MusicPitchName {
        let rawValue = wrappableModulo(self.rawValue + offset, mod: 7)
        return MusicPitchName(rawValue: rawValue)!
    }
    
    ///Provides the next name in ascending scale order
    public var nextName: MusicPitchName {
        return self.offset(by: 1)
    }
    
    ///Provides the next name in descending scale order
    public var previousName: MusicPitchName {
        return self.offset(by: -1)
    }
    
    ///A version of the modulo operator that rolls over when negative.
    ///
    ///e.g. -2 % 7 would normally return -2, but in this case returns 4, as it wraps around from the maximum value of 6.
    ///
    ///- parameter num: The dividend (the left-hand side of the modulo operation)
    ///- parameter mod: The divisor (the right-hand side of the modulo operation)
    ///- returns: `num % mod` if the result is positive, `mod - abs(num % mod)` if the result of `num % mod` is negative
    private func wrappableModulo(_ num: Int, mod: Int) -> Int {
        let laps = abs(num / mod) + 1
        return (mod * laps + num) % mod
    }
    
    ///Provides non-localized name descriptions for debugging purposes
    public var debugDescription: String {
        switch self {
        case .c:
            return "C"
        case .d:
            return "D"
        case .e:
            return "E"
        case .f:
            return "F"
        case .g:
            return "G"
        case .a:
            return "A"
        case .b:
            return "B"
        }
    }
}
