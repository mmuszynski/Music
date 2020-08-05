//
//  MusicIntervalError.swift
//  Music
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

/// An `Error` describing the various reasons that a `MusicInterval` could not be created
///
/// - InvalidQualityQuantityCombination: The `MusicIntervalQuality` is invalid or does not match the `MusicIntervalQuantity` (e.g. Perfect Third)
/// - InvalidNaturalLangaugeString: The `String` used to initialize the interval was invalid
/// - CouldNotComputeDestniationPitch: The destination pitch could not be computed. Usually this means that the destination pitch would require an exotic modifier such as a triple flat.
/// - undefined: Any error that does not fit into the above. This is slated to be removed in a future release.
public enum MusicIntervalError: Error {
    case InvalidQualityQuantityCombination
    case InvalidNaturalLangaugeString
    case CouldNotComputeDestniationPitch(quality: MusicIntervalQuality, quantity: MusicIntervalQuantity, direction: MusicIntervalDirection, rootPitch: MusicPitch)
    case undefined(reason: String)
}
