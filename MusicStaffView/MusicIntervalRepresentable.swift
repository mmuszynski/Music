//
//  MusicIntervalRepresentable.swift
//  MusicStaffView
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
    func pitches(from root: MusicPitch) throws -> [MusicPitch]
}

public protocol MusicIntervalRepresentableUpward: MusicIntervalRepresentable {
    var upwardIntervalDescription: [MusicInterval] { get }
}

public protocol MusicIntervalRepresentableDownward: MusicIntervalRepresentable {
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

public extension MusicIntervalRepresentableDownward {
    func downwardPitches(from root: MusicPitch) throws -> [MusicPitch] {
        var pitches = [root]
        for interval in downwardIntervalDescription {
            let lastPitch = pitches.last!
            let nextPitch = try interval.destinationPitch(withRootPitch: lastPitch)
            pitches.append(nextPitch)
        }
        return pitches
    }
}

public extension MusicIntervalRepresentableUpward {
    func upwardPitches(from root: MusicPitch) throws -> [MusicPitch] {
        var pitches = [root]
        for interval in upwardIntervalDescription {
            let lastPitch = pitches.last!
            let nextPitch = try interval.destinationPitch(withRootPitch: lastPitch)
            pitches.append(nextPitch)
        }
        return pitches
    }
}
