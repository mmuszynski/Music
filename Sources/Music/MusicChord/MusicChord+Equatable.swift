//
//  MusicChord+Equatable.swift
//  Music
//
//  Created by Mike Muszynski on 4/1/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

extension MusicChord: Equatable {
    /// Returns a Boolean value indicating whether two `MusicChord` values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A `MusicChord`.
    ///   - rhs: Another `MuiscChord` to compare.
    public static func ==(lhs: MusicChord, rhs: MusicChord) -> Bool {
        return lhs.pitches == rhs.pitches
    }
}
