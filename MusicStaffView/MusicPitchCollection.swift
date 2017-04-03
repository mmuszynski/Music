//
//  MusicPitchCollection.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/2/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

internal protocol MusicPitchCollection: Collection, MusicTransposable {
    var pitches: [MusicPitch] { get set }
    init(pitches: [MusicPitch])
}

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

extension MusicPitchCollection {
    func transposed(by interval: MusicInterval) throws -> Self {
        return Self(pitches: try pitches.map { try $0.transposed(by: interval) })
    }
}
