//
//  MusicPitchCollection.swift
//  Music
//
//  Created by Mike Muszynski on 4/2/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

/// Describes a Collection consisting of `MusicPitch` objects. This should also adopt `MusicTransposable`, as the MusicPitch elements can be transposed.
internal protocol MusicPitchCollection: Collection, MusicTransposable {
    var pitches: [MusicPitch] { get set }
}

/// Extends `MusicPitchCollection` to give a default `Collection` implementation.
extension MusicPitchCollection {
    public var startIndex: Int {
        return pitches.startIndex
    }
    public var endIndex: Int {
        return pitches.endIndex
    }
    public subscript(position: Int) -> MusicPitch {
        return pitches[position]
    }
    public func index(after i: Int) -> Int {
        return pitches.index(after: i)
    }
}

/// Extends `MusicPitchCollection` to give a default `MusicTransposable` implementation.
extension MusicPitchCollection {
    public func transposed(by interval: MusicInterval) throws -> Self {
        var newSelf = self
        newSelf.pitches = try self.pitches.map { try $0.transposed(by: interval) }
        return newSelf
    }
}
