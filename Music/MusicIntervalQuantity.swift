//
//  MusicIntervalQuantity.swift
//  Music
//
//  Created by Mike Muszynski on 3/27/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicIntervalQuantity: CustomStringConvertible, CustomDebugStringConvertible {
    case unison, second, third, fourth, fifth, sixth, seventh, octave
    indirect case compound(octaves: Int, plusQuantity: MusicIntervalQuantity)
    
    public init(rawValue: Int) {
        switch abs(rawValue) {
        case 0:
            self = .unison
        case 1:
            self = .second
        case 2:
            self = .third
        case 3:
            self = .fourth
        case 4:
            self = .fifth
        case 5:
            self = .sixth
        case 6:
            self = .seventh
        case 7:
            self = .octave
        default:
            let octave = abs(rawValue) / 7
            let quantity = abs(rawValue) % 7
            self = .compound(octaves: octave, plusQuantity: MusicIntervalQuantity(rawValue: quantity))
        }
    }
    
    //This is a doozy. There is an indirect quantity (generic) that takes an octave plus a quantity.
    //But it's probably not good to let it recurse generally. So let's hope that it only recurses once.
    //Can we break that? Who knows at this point.
    var rawValue: Int {
        switch self {
        case .unison:
            return 0
        case .second:
            return 1
        case .third:
            return 2
        case .fourth:
            return 3
        case .fifth:
            return 4
        case .sixth:
            return 5
        case .seventh:
            return 6
        case .octave:
            return 7
        case .compound(let octave, let quantity):
            guard octave >= 0 else {
                fatalError()
            }
            
            switch quantity {
            case .compound(_, _):
                fatalError()
            default:
                return octave * 7 + quantity.rawValue
            }
        }
    }
    
    var isPerfectType: Bool {
        let raw = self.rawValue % 7
        return raw == 0 || raw == 3 || raw == 4
    }
    
    
    /// The amount of half steps the interval will modify the root note if the interval is perfect or major
    var modifier: Int {
        switch self {
        case .unison:
            return 0
        case .second:
            return 2
        case .third:
            return 4
        case .fourth:
            return 5
        case .fifth:
            return 7
        case .sixth:
            return 9
        case .seventh:
            return 11
        case .octave:
            return 12
        case .compound(let octave, let quantity):
            guard octave >= 0 else {
                fatalError()
            }
            
            switch quantity {
            case .compound(_, _):
                fatalError()
            default:
                return octave * 12 + quantity.modifier
            }
        }
    }
    
    public var description: String {
        switch self {
        case .unison:
            return "unison"
        case .second:
            return "second"
        case .third:
            return "third"
        case .fourth:
            return "fourth"
        case .fifth:
            return "fifth"
        case .sixth:
            return "sixth"
        case .seventh:
            return "seventh"
        case .octave:
            return "octave"
        case .compound(let octave, let quantity):
            return "\(octave) octave" + (octave > 1 ? "s" : "") + " plus " + quantity.description
        }
    }
    
    public var debugDescription: String {
        return "\(self.rawValue + 1)"
    }
    
}

extension MusicIntervalQuantity: Equatable {
    public static func ==(lhs: MusicIntervalQuantity, rhs: MusicIntervalQuantity) -> Bool {
        switch (lhs, rhs) {
        case (.unison, .unison):
            return true
        case (.second, .second):
            return true
        case (.third, .third):
            return true
        case (.fourth, .fourth):
            return true
        case (.fifth, .fifth):
            return true
        case (.sixth, .sixth):
            return true
        case (.seventh, .seventh):
            return true
        case (.octave, .octave):
            return true
        case (let .compound(x1, y1), let .compound(x2, y2)):
            return x1 == x2 && y1 == y2
        default:
            return false
        }
    }
}
