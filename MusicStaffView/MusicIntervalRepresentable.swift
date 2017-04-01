//
//  MusicIntervalRepresentable.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/31/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public protocol MusicIntervalRepresentable {
    var intervalDescription: [MusicInterval] { get }
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
