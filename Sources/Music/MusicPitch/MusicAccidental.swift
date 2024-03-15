//
//  MusicAccidental.swift
//  Music
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

/// The possible accidentals used in creating notes and key signagures
public enum MusicAccidental: Int, Codable, CustomStringConvertible, CustomDebugStringConvertible, Sendable, RawRepresentable {
    case doubleFlat = -2
    case flat
    case natural
    case sharp
    case doubleSharp
    
    @available(*, unavailable, renamed: "natural")
    case none
    
    /// The number of half steps that a given accidental value raises (or lowers if negative) a given pitch
    public var enharmonicModifier: Int {
        return self.rawValue
    }
    
    /// Initializes a `MusicAccidental` with a given `enharmonicModifier`, returning nil if the modifier value is invalid.
    public init?(enharmonicModifier: Int) {
        self.init(rawValue: enharmonicModifier)
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

extension MusicAccidental: CaseIterable {
    public typealias AllCases = [MusicAccidental]
    public static var allCases: AllCases {
        return [-2, -1, 0, 1, 2].map { MusicAccidental(rawValue: $0)! }
    }
}
