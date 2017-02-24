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
            return 2
        case .diminished:
            return -2
        default:
            return nil
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

public enum MusicIntervalQuantity: CustomStringConvertible, CustomDebugStringConvertible {
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
    
    var modifier: Int {
        return 0
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
        case .generic(let octave, let quantity):
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
    case InvalidNaturalLangaugeString
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

    ///Attempts to build a quality and quantity a known number of half steps and staff offset
    ///
    ///- parameter halfSteps: The distance in half steps between the two notes
    ///- parameter offset: The distance the notes would be drawn on a staff (e.g. the distance between C and D is 1)
    static func offsetAndEnharnomicModifier(withQuality quality: MusicIntervalQuality, quantity: MusicIntervalQuantity) throws -> (offset: Int, modifier: Int) {
        let modifier: Int
        if quantity.isPerfectType {
            guard ![MusicIntervalQuality.major, MusicIntervalQuality.minor].contains(quality) else {
                throw MusicIntervalError.InvalidQuality
            }
            
            let qualityModifier = quality.perfectModifier!
            modifier = quantity.modifier + qualityModifier
        } else {
            guard quality != .perfect else {
                throw MusicIntervalError.InvalidQuality
            }
            
            let qualityModifier = quality.majorMinorModifier!
            modifier = quantity.modifier + qualityModifier
        }
        
        return (offset: quantity.rawValue, modifier: modifier)
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
    
    ///Initializes an interval from a given quality and quantity.
    public init(quality: MusicIntervalQuality, quantity: MusicIntervalQuantity, rootPitch: MusicPitch = MusicPitch(name: .c, accidental: .natural, octave: 0)) throws {
        self.rootPitch = rootPitch
        if quantity.isPerfectType && (quality == .major || quality == .minor) {
            throw MusicIntervalError.InvalidQuality
        }
        let offset = quantity.rawValue
        let name = rootPitch.name.offset(by: offset)
        guard let destination = MusicPitch(enharmonicIndex: 70, name: name) else {
            throw MusicIntervalError.undefined(reason: "Couldn't figure out a destination pitch")
        }
        self.destinationPitch =  destination
        self.quality = quality
        self.quantity = quantity
        self.range = Range<MusicPitch>(uncheckedBounds: (lower: rootPitch, upper: destinationPitch))
    }
    
    ///Initializes based on a natural language string.
    ///
    ///
    public init(string: String) throws {
        let qualityNames = MusicIntervalQuality.allDescriptions.map { $0.lowercased() }
        let foundQuality = qualityNames.filter { string.contains($0) }
        guard foundQuality.count == 1 else {
            throw MusicIntervalError.InvalidNaturalLangaugeString
        }
        
    }
}
