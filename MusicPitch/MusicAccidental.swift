//
//  MusicAccidental.swift
//  Music
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

/// The possible accidentals used in creating notes and key signagures
public enum MusicAccidental: Int, Codable, CustomStringConvertible, CustomDebugStringConvertible {
    case flat
    case natural
    case sharp
    case doubleFlat
    case doubleSharp
    
    /// The number of half steps that a given accidental value raises (or lowers if negative) a given pitch
    public var enharmonicModifier: Int {
        switch self {
        case .natural:
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
    
    /// Initializes a `MusicAccidental` with a given `enharmonicModifier`, returning nil if the modifier value is invalid.
    public init?(enharmonicModifier: Int) {
        switch enharmonicModifier {
        case 0:
            self = .natural
        case -1:
            self = .flat
        case -2:
            self = .doubleFlat
        case 1:
            self = .sharp
        case 2:
            self = .doubleSharp
        default:
            return nil
        }
    }
    
    public var description: String {
        return debugDescription
    }
    
    /// Debug description
    public var debugDescription: String {
        switch self {
        case .natural:
            return ""
        case .flat:
            return "b"
        case .doubleFlat:
            return "bb"
        case .sharp:
            return "#"
        case .doubleSharp:
            return "x"
        }
    }
}
