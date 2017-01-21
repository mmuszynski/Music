//
//  MusicInterval.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 12/20/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicIntervalQuality {
    case perfect, major, minor, diminished, augmented
}

public enum MusicIntervalQuantity {
    case unison, second, third, fourth, fifth, sixth, seventh, octave
    indirect case generic(octave: Int, plusQuantity: MusicIntervalQuantity)
    
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
            self = .generic(octave: octave, plusQuantity: MusicIntervalQuantity(rawValue: quantity))
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
        case .generic(let octave, let quantity):
            guard octave >= 0 else {
                fatalError()
            }
            
            switch quantity {
            case .generic(_, _):
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
        case (let .generic(x1, y1), let .generic(x2, y2)):
            return x1 == x2 && y1 == y2
        default:
            return false
        }
    }
}

public enum MusicIntervalError: Error {
    case InvalidQuality
    case InvalidQuantity
    case undefined(reason: String)
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
        let translatedHalfSteps = abs(halfSteps) % 12
        
        guard quantity != .unison else {
            switch halfSteps {
            case 0:
                quality = .perfect
            case 1, -1:
                quality = .augmented
            default:
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
                quality = .diminished
            }
        case 1:
            switch translatedHalfSteps {
            case 0:
                quality = .diminished
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
                quality = .diminished
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
                quality = .diminished
            }
        case 4:
            switch translatedHalfSteps {
            case 7:
                quality = .perfect
            case 8:
                quality = .augmented
            default:
                quality = .diminished
            }
        case 5:
            switch translatedHalfSteps {
            case 7:
                quality = .diminished
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
                quality = .diminished
            case 10:
                quality = .minor
            case 11:
                quality = .major
            default:
                quality = .augmented
            }
        default:
            throw MusicIntervalError.undefined(reason: "\(#line)")
        }
        
        return (quality, quantity)
    }
    
    //INITIALIZERS
    ///Initializes an interval from a root pitch and a destination pitch.
    ///
    ///- parameter rootPitch: The basic root pith of the interval
    ///- parameter destinationPitch: The secondary pitch that completes the definition of the interval
    ///
    ///Computes quality and quantity (i.e. major third) based on the relative distance of the destination pitch from the root pitch. Throws an error if a valid interval cannot be created (e.g. a diminished unison makes little sense, as there is no way to lower a unison in order to diminish its magnitude).
    ///
    ///Further, doubly-diminished and doubly-augmented intervals, while potentially musically valid, have not been defined in this library.
    ///
    ///- throws: `MusicIntervalError` if unable to compute a proper `MusicIntervalQuality`.
    ///
    ///- important: Downward intervals have yet to be defined
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
