//
//  MusicPitchAccidental.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicPitchAccidental: CustomDebugStringConvertible {
    case none
    case flat
    case natural
    case sharp
    case doubleFlat
    case doubleSharp
    
    var enharmonicModifier: Int {
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
    
    init?(enharmonicModifier: Int) {
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
    
    public var debugDescription: String {
        switch self {
        case .none, .natural:
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