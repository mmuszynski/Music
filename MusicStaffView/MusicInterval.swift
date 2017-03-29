//
//  MusicInterval.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 12/20/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

public typealias IntervalTriple = (MusicIntervalDirection, MusicIntervalQuality, MusicIntervalQuantity)

public enum MusicIntervalDirection {
    case upward, downward
}

/// An `Error` describing the various reasons that a `MusicInterval` could not be created
///
/// - InvalidQuality: The `MusicIntervalQuality` is invalid or does not match the `MusicIntervalQuantity` (e.g. Perfect Third)
/// - InvalidQuantity: The `MusicIntervalQuantity` is invalid
/// - InvalidNaturalLangaugeString: The `String` used to initialize the interval was invalid
/// - CouldNotComputeDestniationPitch: The destination pitch could not be computed. Usually this means that the destination pitch would require an exotic modifier such as a triple flat.
/// - undefined: Any error that does not fit into the above. This is slated to be removed in a future release.
public enum MusicIntervalError: Error {
    case InvalidQuality
    case InvalidQuantity
    case InvalidNaturalLangaugeString
    case CouldNotComputeDestniationPitch(quality: MusicIntervalQuality, quantity: MusicIntervalQuantity, direction: MusicIntervalDirection, rootPitch: MusicPitch)
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
    
    ///The `ClosedRange<MusicNote>` defined by this interval
    var range: ClosedRange<MusicPitch>
    
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
        self.range = ClosedRange<MusicPitch>(uncheckedBounds: (lower: rootPitch, upper: destinationPitch))
    }
    
    
    ///Initializes an interval from a given quality, quantity, and direction.
    ///
    /// - Parameters:
    ///   - quality: `MusicIntervalQuality` describing the quality of the interval
    ///   - quantity: `MusicIntervalQuantity` describing the quantity of the interval
    ///   - direction: `MusicIntervalDirection` describing the direction of the interval
    ///   - rootPitch: `MusicPitch` describing the root pitch of the interval
    /// - Throws: `MusicIntervalError` if a destination pitch cannot be computed or if a quality and quantity do not make a valid couple
    ///
    public init(quality: MusicIntervalQuality, quantity: MusicIntervalQuantity, direction: MusicIntervalDirection, rootPitch: MusicPitch = MusicPitch(name: .c, accidental: .natural, octave: 0)) throws {
        self.rootPitch = rootPitch
        if quantity.isPerfectType && (quality == .major || quality == .minor) {
            throw MusicIntervalError.InvalidQuality
        }
        var (offset, ehm) = try MusicInterval.offsetAndEnharnomicModifier(withQuality: quality, quantity: quantity)
        if direction == .downward {
            offset = -offset
            ehm = -ehm
        }
        
        let name = rootPitch.name.offset(by: offset)
        guard let destination = MusicPitch(enharmonicIndex: rootPitch.enharmonicIndex + ehm, name: name) else {
            throw MusicIntervalError.CouldNotComputeDestniationPitch(quality: quality, quantity: quantity, direction: direction, rootPitch: rootPitch)
        }
        self.destinationPitch =  destination
        self.quality = quality
        self.quantity = quantity
        self.range = ClosedRange<MusicPitch>(uncheckedBounds: (lower: rootPitch, upper: destinationPitch))
    }
    
    @available(*,unavailable)
    /// Initalizes from a natural language string
    ///
    /// - Parameter string: Natural language string, e.g. m3
    /// - Throws: `MusicIntervalError` if the interval cannot be created
    public init(naturalLanguageString: String) throws {
        let qualityNames = MusicIntervalQuality.allDescriptions.map { $0.lowercased() }
        let foundQuality = qualityNames.filter { naturalLanguageString.contains($0) }
        guard foundQuality.count == 1 else {
            throw MusicIntervalError.InvalidNaturalLangaugeString
        }
        fatalError()
    }
}
