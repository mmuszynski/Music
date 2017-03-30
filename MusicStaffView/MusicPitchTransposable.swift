//
//  MusicPitchTransposable.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

extension MusicPitch: MusicTransposable {
    func transposed(by interval: MusicIntervalTriple) throws -> MusicPitch {
        let interval = try MusicInterval(quality: interval.quality, quantity: interval.quantity, direction: interval.direction, rootPitch: self)
        return interval.destinationPitch
    }
}
