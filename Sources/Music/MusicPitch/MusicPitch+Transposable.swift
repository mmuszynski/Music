//
//  MusicPitchTransposable.swift
//  Music
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

///Default implementation for transposing a music pitch.
extension MusicPitch: MusicTransposable {
    public func transposed(by interval: MusicInterval) throws -> MusicPitch {
        return try interval.destinationPitch(from: self)
    }
}
