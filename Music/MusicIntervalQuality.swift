//
//  MusicIntervalQuality.swift
//  Music
//
//  Created by Mike Muszynski on 3/27/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicIntervalQuality {
    case perfect, major, minor, diminished, augmented
    
    var perfectModifier: Int? {
        switch self {
        case .perfect:
            return 0
        case .augmented:
            return 1
        case .diminished:
            return -1
        default:
            return nil
        }
    }
    
    var majorMinorModifier: Int? {
        switch self {
        case .major:
            return 0
        case .minor:
            return -1
        case .augmented:
            return 1
        case .diminished:
            return -2
        default:
            return nil
        }
    }
    
    var complement: MusicIntervalQuality {
        switch self {
        case .perfect:
            return .perfect
        case .augmented:
            return .diminished
        case .diminished:
            return .augmented
        case .major:
            return .minor
        case .minor:
            return .major
        }
    }
}

extension MusicIntervalQuality: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        switch self {
        case .perfect:
            return "Perfect"
        case .augmented:
            return "Augmented"
        case .diminished:
            return "Diminished"
        case .major:
            return "Major"
        case .minor:
            return "Minor"
        }
    }
    
    public var debugDescription: String {
        switch self {
        case .perfect:
            return "P"
        case .augmented:
            return "A"
        case .diminished:
            return "d"
        case .major:
            return "M"
        case .minor:
            return "m"
        }
    }
    
    static var allValues: [MusicIntervalQuality] {
        return [.perfect, .augmented, .diminished, .major, .minor]
    }
    
    static var allDescriptions: [String] {
        let allValues = MusicIntervalQuality.allValues
        let allDesc = allValues.map { $0.description } + allValues.map { $0.debugDescription }
        return allDesc
    }
}
