//
//  MusicPitchCollection.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/2/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

internal protocol MusicPitchCollection: Collection {
    var notes: [MusicPitch] { get set }
}

extension MusicPitchCollection {
    public var startIndex: Int {
        return notes.startIndex
    }
    public var endIndex: Int {
        return notes.endIndex
    }
    public subscript(position: Int) -> MusicPitch {
        return notes[position]
    }
    public func index(after i: Int) -> Int {
        return notes.index(after: i)
    }
}

