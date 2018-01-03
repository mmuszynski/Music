//
//  MusicPitch+Hashable.swift
//  Music
//
//  Created by Mike Muszynski on 1/3/18.
//  Copyright © 2018 Mike Muszynski. All rights reserved.
//

import Foundation

/// Indicates enharmonic equivalence, i.e. that two notes are played by the same key on a keyboard.
infix operator ~==: ComparisonPrecedence

extension MusicPitch: Hashable, Equatable {
    public static func ==(lhs: MusicPitch, rhs: MusicPitch) -> Bool {
        if lhs.name != rhs.name {
            return false
        } else if rhs.octave != lhs.octave {
            return false
        } else if rhs.accidental != lhs.accidental {
            return false
        }
        
        return true
    }
    
    public var hashValue: Int {
        return enharmonicIndex.hashValue ^ name.hashValue ^ accidental.hashValue
    }
    
    static func ~==(lhs: MusicPitch, rhs: MusicPitch) -> Bool {
        return lhs.enharmonicIndex == rhs.enharmonicIndex
    }
    
    public func isEnharmonicEquivalent(of pitch: MusicPitch) -> Bool {
        return self ~== pitch
    }
}

extension MusicPitch: Comparable {
    /// Returns a Boolean value indicating whether the `enharmonicIndex` of the first pitch is less than that of the second pitch.
    ///
    /// In cases where this value is equal, returns a Boolean value indicating whether the first pitch would be drawn lower on the staff than the second.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A pitch to compare.
    ///   - rhs: Another pitch to compare.
    public static func <(lhs: MusicPitch, rhs: MusicPitch) -> Bool {
        guard lhs.enharmonicIndex != rhs.enharmonicIndex else {
            return lhs.relativeOffset(for: rhs) > 0
        }
        return lhs.enharmonicIndex < rhs.enharmonicIndex
    }
}

extension MusicPitch: CustomDebugStringConvertible {
    ///A more easily readable version of the description
    public var debugDescription: String {
        let name = self.name.debugDescription
        let accidentalName = self.accidental.debugDescription
        let octaveName = "\(self.octave)"
        return name + accidentalName + octaveName
    }
}
