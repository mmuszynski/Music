//
//  MusicScale.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/16/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

///Describes the direction of a music scale.
///
///Certain musical scales have different forms in the upward direction than they do in the downward direction. This enum is used in combination with `MusicScaleMode` to fully define a scalar mode.
enum MusicScaleDirection {
    case up, down
}

///Describes the mode of a music scale.
///
///A musical scale can be defined by its mode, which describes the relationships between the notes of the scale. For example, a major scale's pattern of half and whole steps (WWHWWWH) provides the blueprint for any major scale starting on any given note. These scales will all sound the same, only with different starting pitches.
///
/// - bug: Currently, scales which skip note names (e.g. Pentatonic: A-B-D-E-F, contains no C) are not representable. There is no workaround yet.
enum MusicScaleMode {
    case major, harmonicMinor, naturalMinor, melodicMinor, majorPentatonic
    
    var halfStepDescription: [Int] {
        switch self {
        case .major:
            return [2, 2, 1, 2, 2, 2]
        case .harmonicMinor:
            return [2, 1, 2, 2, 1, 3]
        case .naturalMinor:
            return [2, 1, 2, 2, 1, 2]
        case .melodicMinor:
            return [2, 1, 2, 2, 2, 2, 1, -2, -2, -1, -2, -2, -1, -2]
        case .majorPentatonic:
            return [2, 2, 100, 2, 2, 100]
        }
    }
    
    var intervalDescription: [(MusicIntervalDirection, MusicIntervalQuality, MusicIntervalQuantity)] {
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
                    (.upward, .major, .second),
                    (.upward, .major, .second),
                    (.upward, .major, .second)]
        }
    }
}


/// A `Collection` type that describes the pitches of a given `MusicScaleMode`.
///
/// Musical scales lend themselves to a collection-type, acting as an immutable array of `MusicNote` objects.
public struct MusicScale: Collection {
    private var notes: [_Element] = []
    public typealias _Element = MusicPitch
    
    public var startIndex: Int {
        return notes.startIndex
    }
    public var endIndex: Int {
        return notes.endIndex
    }
    public subscript(position: Int) -> _Element {
        return notes[position]
    }
    public func index(after i: Int) -> Int {
        return notes.index(after: i)
    }
    
    
    /// Initializes a `MusicScale`.
    ///
    /// - Parameters:
    ///   - root: The root `MusicNote` that the scale is built on
    ///   - mode: The `MusicScaleMode` that defines the scale
    ///   - direction: A `MusicScaleDirection` defining the direction of the scale (e.g. up, down, both). Defaults to upward.
    ///
    /// - note: By definition, `MusicScale` includes two octaves of the root note
    init(root: _Element, mode: MusicScaleMode, direction: MusicScaleDirection = .up) {
        var scalePitches = [root]

        let intervals = mode.intervalDescription
        for (direction, quality, quantity) in intervals {
            let currentPitch = scalePitches.last!
            do {
                let interval = try MusicInterval(quality: quality, quantity: quantity, direction: direction, rootPitch: currentPitch)
                let nextPitch = interval.destinationPitch
                scalePitches.append(nextPitch)
            } catch {
                fatalError("\(error)")
            }
        }
        
        notes = scalePitches
    }
    
    public static func ==(lhs: MusicScale, rhs: [MusicPitch]) -> Bool {
        return lhs.notes == rhs
    }
    

}
