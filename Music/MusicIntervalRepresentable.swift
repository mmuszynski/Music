//
//  MusicIntervalRepresentable.swift
//  Music
//
//  Created by Mike Muszynski on 3/31/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

/// An object whose form can be represented by an ordered Array of `MusicInterval` objects.
///
/// Musical concepts such as Scales and Chords are defined by the intervals between their pitches. For example, a major scale consists of a specific pattern of major seconds and minor seconds. These intervals, combined with a root pitch, fully define the collection of pitches that comprise the scale.
public protocol MusicIntervalRepresentable {
    
    /// A set of `MusicIntervals` that describes the collection
    var intervalDescription: [MusicInterval] { get }
    
    
    /// The pitches that define the collection when created from a root `MusicPitch.`
    ///
    /// - Parameter root: `MusicPitch` defining the root pitch of the collection
    /// - Returns: An array of `MusicPitch` values defining the collection
    /// - Throws: An appropriate error if the pitches are not able to be described
    func pitches(from root: MusicPitch) throws -> [MusicPitch]
}

/// An object whose form can be represented by an ordered Array of `MusicInterval` objects and whose form is different upward than it is downward.
public protocol MusicIntervalRepresentableDirectional: MusicIntervalRepresentable {
    var upwardIntervalDescription: [MusicInterval] { get }
    var downwardIntervalDescription: [MusicInterval] { get }
}

public extension MusicIntervalRepresentable {
    func pitches(from root: MusicPitch) throws -> [MusicPitch] {
        var pitches = [root]
        for interval in intervalDescription {
            let lastPitch = pitches.last!
            let nextPitch = try interval.destinationPitch(withRootPitch: lastPitch)
            pitches.append(nextPitch)
        }
        return pitches
    }
}

public extension MusicIntervalRepresentableDirectional {
    func downwardPitches(from root: MusicPitch) throws -> [MusicPitch] {
        var pitches = [root]
        for interval in downwardIntervalDescription {
            let lastPitch = pitches.last!
            let nextPitch = try interval.destinationPitch(withRootPitch: lastPitch)
            pitches.append(nextPitch)
        }
        return pitches
    }
    
    func upwardPitches(from root: MusicPitch) throws -> [MusicPitch] {
        var pitches = [root]
        for interval in upwardIntervalDescription {
            let lastPitch = pitches.last!
            let nextPitch = try interval.destinationPitch(withRootPitch: lastPitch)
            pitches.append(nextPitch)
        }
        return pitches
    }
    
    var intervalDescription: [MusicInterval] {
        return upwardIntervalDescription + downwardIntervalDescription
    }
}
