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
///
/// - up: The upward direction
/// - down: The downward direction
/// - circular: Both upward and downward directions
enum MusicScaleDirection {
    case up, down, circular
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

        let intervals: Array<MusicInterval>
        switch direction {
        case .up:
            intervals = mode.upwardIntervalDescription
        case .down:
            intervals = mode.downwardIntervalDescription
        case .circular:
            intervals = mode.circularIntervalDescription
        }
        for interval in intervals {
            let direction = interval.direction
            let quantity = interval.quantity
            let quality = interval.quality
            
            let currentPitch = scalePitches.last!
            do {
                let interval = try MusicInterval(direction: direction, quality: quality, quantity: quantity)
                let nextPitch = try interval.destinationPitch(withRootPitch: currentPitch)
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
