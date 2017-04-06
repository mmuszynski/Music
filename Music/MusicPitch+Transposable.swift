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
        let interval = try MusicInterval(direction: interval.direction, quality: interval.quality, quantity: interval.quantity)
        return try interval.destinationPitch(withRootPitch: self)
    }
}
