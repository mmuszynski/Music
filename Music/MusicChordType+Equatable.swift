//
//  MusicChordType+Equatable.swift
//  Music
//
//  Created by Mike Muszynski on 4/3/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

extension MusicChordType: Equatable {
    /// Returns a Boolean value indicating whether two `MusicChordType` values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A `MusicChordType`.
    ///   - rhs: Another `MusicChordType` to compare.
    public static func ==(lhs: MusicChordType, rhs: MusicChordType) -> Bool {
        return lhs.intervalDescription == rhs.intervalDescription
    }
}
