//
//  MusicScale.swift
//  Music
//
//  Created by Mike Muszynski on 1/16/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

///Describes the direction of a music scale.
///
///Certain musical scales have different forms in the upward direction than they do in the downward direction. This enum is used in combination with `MusicScaleMode` to fully define a scalar mode.
///
/// - up: The upward direction
/// - down: The downward direction
/// - circular: Both upward and downward directions
public enum MusicScaleDirection {
    case up, down, circular
}

/// A `Collection` type that describes the pitches of a given `MusicScaleMode`.
///
/// Musical scales lend themselves to a collection-type, acting as an immutable array of `MusicPitch` objects.
public struct MusicScale: MusicPitchCollection {
    internal var pitches: [_Element] = []
    public typealias _Element = MusicPitch
    
    /// Initializes a `MusicScale`.
    ///
    /// - Parameters:
    ///   - root: The root `MusicPitch` that the scale is built on
    ///   - mode: The `MusicScaleMode` that defines the scale
    ///   - direction: A `MusicScaleDirection` defining the direction of the scale (e.g. up, down, both). Defaults to upward.
    ///
    /// - note: By definition, `MusicScale` includes two octaves of the root note
    public init(root: _Element, mode: MusicScaleMode, direction: MusicScaleDirection = .circular) throws {
        switch direction {
        case .up:
            pitches = try mode.upwardPitches(from: root)
        case .down:
            pitches = try mode.downwardPitches(from: root)
        case .circular:
            let upward = try mode.upwardPitches(from: root)[0..<mode.upwardIntervalDescription.count]
            let downward = try mode.downwardPitches(from: root)
            pitches = upward + downward
        }
    }
    
    public static func ==(lhs: MusicScale, rhs: [MusicPitch]) -> Bool {
        return lhs.pitches == rhs
    }
    

}
