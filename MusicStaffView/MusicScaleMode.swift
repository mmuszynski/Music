//
//  MusicScaleMode.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/28/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

///Describes the mode of a music scale.
///
///A musical scale can be defined by its mode, which describes the relationships between the notes of the scale. For example, a major scale's pattern of half and whole steps (WWHWWWH) provides the blueprint for any major scale starting on any given note. These scales will all sound the same, only with different starting pitches.
///
/// - bug: Currently, scales which skip note names (e.g. Pentatonic: A-B-D-E-F, contains no C) are not representable. There is no workaround yet.
enum MusicScaleMode {
    case major, harmonicMinor, naturalMinor, melodicMinor, majorPentatonic
    
    var upwardIntervalDescription: [IntervalTriple] {
        switch self {
        case .major:
            return [(.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .minor, .second),
                    (.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .minor, .second)]
        case .harmonicMinor:
            return [(.upward, .major, .second),
                    (.upward, .minor, .second),
                    (.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .minor, .second),
                    (.upward, .augmented, .second),
                    (.upward, .minor, .second)]
        case .naturalMinor:
            return [(.upward, .major, .second),
                    (.upward, .minor, .second),
                    (.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .minor, .second),
                    (.upward, .major, .second),
                    (.upward, .major, .second)]
        case .melodicMinor:
            return [(.upward, .major, .second),
                    (.upward, .minor, .second),
                    (.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .minor, .second),
                    (.downward, .major, .second),
                    (.downward, .major, .second),
                    (.downward, .minor, .second),
                    (.downward, .major, .second),
                    (.downward, .major, .second),
                    (.downward, .minor, .second),
                    (.downward, .major, .second)]
        case .majorPentatonic:
            return [(.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .minor, .third),
                    (.upward, .major, .second)]
        }
    }
    
    var downwardIntervalDescription: [IntervalTriple] {
        
        return self.upwardIntervalDescription.reversed().map({
            (direction, quality, quantity) -> IntervalTriple in
                return (.downward, quality, quantity)
        })
    }
    
    var circularIntervalDescription: [IntervalTriple] {
        return self.upwardIntervalDescription + self.downwardIntervalDescription
    }
}
