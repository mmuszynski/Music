//
//  MusicScale.swift
//  MusicStaffView
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
enum MusicScaleDirection {
    case up, down, circular
}

/// A `Collection` type that describes the pitches of a given `MusicScaleMode`.
///
/// Musical scales lend themselves to a collection-type, acting as an immutable array of `MusicNote` objects.
public struct MusicScale: MusicPitchCollection {
    internal var pitches: [_Element] = []
    public typealias _Element = MusicPitch
    
    /// Initializes a `MusicScale`.
    ///
    /// - Parameters:
    ///   - root: The root `MusicNote` that the scale is built on
    ///   - mode: The `MusicScaleMode` that defines the scale
    ///   - direction: A `MusicScaleDirection` defining the direction of the scale (e.g. up, down, both). Defaults to upward.
    ///
    /// - note: By definition, `MusicScale` includes two octaves of the root note
    init(root: _Element, mode: MusicScaleMode, direction: MusicScaleDirection = .up) throws {
        switch direction {
        case .up:
            pitches = try mode.upwardPitches(from: root)
        case .down:
            pitches = try mode.downwardPitches(from: root)
        case .circular:
            pitches = try mode.pitches(from: root)
        }
    }
    
    internal init(pitches: [MusicPitch]) {
        self.pitches = pitches
    }
    
    public static func ==(lhs: MusicScale, rhs: [MusicPitch]) -> Bool {
        return lhs.pitches == rhs
    }
    

}
