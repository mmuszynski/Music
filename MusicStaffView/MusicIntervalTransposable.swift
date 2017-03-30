//
//  MusicIntervalTransposable.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

extension MusicInterval: MusicTransposable {
    func transposed(by interval: MusicIntervalTriple) throws -> MusicInterval {
        let intermediateInterval = try MusicInterval(quality: interval.quality, quantity: interval.quantity, direction: interval.direction, rootPitch: self.rootPitch)
        let interval = try MusicInterval(quality: self.quality, quantity: self.quantity, direction: self.direction, rootPitch: intermediateInterval.destinationPitch)
        return interval
    }
}
