//
//  MusicIntervalEquality.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

extension MusicInterval: Equatable {
    public static func ==(lhs: MusicInterval, rhs: MusicInterval) -> Bool {
        return lhs.range == rhs.range
    }
}
