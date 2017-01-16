//
//  MusicInterval.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 12/20/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicIntervalQuality {
    case perfect, major, minor, diminshed, augmented
}

public enum MusicIntervalQuantity {
    case unison, second, third, fourth, fifth, sixth, seventh, octave, generic(num: Int)
    
    public init(rawValue: Int) {
        switch rawValue {
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
            self = .generic(num: rawValue)
        }
    }
    
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
        case .generic(let num):
            return num
        }
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
        case (let .generic(x), let .generic(y)):
            return x == y
        default:
            return false
        }
    }
}

public enum MusicIntervalError: Error {
    case InvalidQuality
}

public struct MusicInterval {
    ///The root pitch of the interval, described as a `MusicPitch`.
    var rootPitch: MusicPitch
    
    ///The destniation pitch of the interval, described as a `MusicPitch`.
    var destinationPitch: MusicPitch
        
    ///The quality of the interval, described as a `MusicIntervalQuality` type.
    var quality: MusicIntervalQuality
    
    ///The quantity of the interval, described as a `MusicIntervalQuantity` type.
    var quantity: MusicIntervalQuantity
    
    ///The `Range<MusicNote>` defined by this interval
    var range: Range<MusicPitch>
    
    ///The number of half steps spanned by the interval.
    ///
    ///Notes that are enharmonically equivalent will return a half-step distance of zero. Upward intervals are described with positive numbers, while downward intervals are described with negative numbers.
    var halfStepDistance: Int {
        return destinationPitch.enharmonicIndex - rootPitch.enharmonicIndex
    }
    
    ///Attempts to build a quality and quantity a known number of half steps and staff offset
    ///
    ///- parameter halfSteps: The distance in half steps between the two notes
    ///- parameter offset: The distance the notes would be drawn on a staff (e.g. the distance between C and D is 1)
    static func qualityAndQuantity(withHalfSteps halfSteps: Int, offset: Int) throws -> (MusicIntervalQuality, MusicIntervalQuantity) {
        let quantity = MusicIntervalQuantity(rawValue: offset)
        let quality: MusicIntervalQuality
        let translatedOffset = quantity.rawValue % 7
        let translatedHalfSteps = halfSteps % 12
        
        guard quantity != .unison else {
            if halfSteps == 0 {
                quality = .perfect
            } else if halfSteps == 1 {
                quality = .augmented
            } else {
                throw MusicIntervalError.InvalidQuality
            }
            return (quality, quantity)
        }
        
        switch translatedOffset {
        case 0:
            switch translatedHalfSteps {
            case 0:
                quality = .perfect
            case 1:
                quality = .augmented
            default:
                quality = .diminshed
            }
        case 1:
            switch translatedHalfSteps {
            case 0:
                quality = .diminshed
            case 1:
                quality = .minor
            case 2:
                quality = .major
            default:
                quality = .augmented
            }
        case 2:
            switch translatedHalfSteps {
            case 2:
                quality = .diminshed
            case 3:
                quality = .minor
            case 4:
                quality = .major
            default:
                quality = .augmented
            }
        case 3:
            switch translatedHalfSteps {
            case 5:
                quality = .perfect
            case 6:
                quality = .augmented
            default:
                quality = .diminshed
            }
        case 4:
            switch translatedHalfSteps {
            case 7:
                quality = .perfect
            case 8:
                quality = .augmented
            default:
                quality = .diminshed
            }
        case 5:
            switch translatedHalfSteps {
            case 7:
                quality = .diminshed
            case 8:
                quality = .minor
            case 9:
                quality = .major
            default:
                quality = .augmented
            }
        case 6:
            switch translatedHalfSteps {
            case 9:
                quality = .diminshed
            case 10:
                quality = .minor
            case 11:
                quality = .major
            default:
                quality = .augmented
            }
        default:
            quality = .perfect
        }
        
        return (quality, quantity)
    }
    
    //INITIALIZERS
    ///Initializes an interval from a root pitch and a destination pitch
    public init(rootPitch: MusicPitch, destinationPitch: MusicPitch) throws {
        self.rootPitch = rootPitch
        self.destinationPitch = destinationPitch
        let offset = destinationPitch.name.rawValue - rootPitch.name.rawValue + (destinationPitch.octave - rootPitch.octave) * 7
        let halfSteps = destinationPitch.enharmonicIndex - rootPitch.enharmonicIndex
        let (quality, quantity) = try MusicInterval.qualityAndQuantity(withHalfSteps: halfSteps, offset: offset)
        
        self.quantity = quantity
        self.quality = quality
        self.range = Range<MusicPitch>(uncheckedBounds: (lower: rootPitch, upper: destinationPitch))
    }
    
//    public init(rootPitch: MusicPitch, quality: MusicIntervalQuality, quantity: MusicIntervalQuantity) throws {
//        self.rootPitch = rootPitch
//        if quality == .major || quality == .minor && (true) {
//            throw MusicIntervalError.InvalidQuality
//        }
//        
//    }
}
