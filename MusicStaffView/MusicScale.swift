//
//  MusicScale.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/16/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

enum MusicScaleMode {
    case major, harmonicMinor, naturalMinor
    
    var halfStepDescription: [Int] {
        switch self {
        case .major:
            return [2, 2, 1, 2, 2, 2]
        case .harmonicMinor:
            return [2, 1, 2, 2, 1, 3]
        case .naturalMinor:
            return [2, 1, 2, 2, 1, 2]
        }
    }
}

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
    
    init(root: _Element, mode: MusicScaleMode) {
        var scalePitches = [root]

        let halfStepDescription = mode.halfStepDescription
        for halfSteps in halfStepDescription {
            let current = scalePitches.last!
            let nextName = current.name.nextName
            let next = MusicPitch(enharmonicIndex: current.enharmonicIndex + halfSteps, name: nextName)
            scalePitches.append(next!)
        }
        
        notes = scalePitches
    }
    
    public static func ==(lhs: MusicScale, rhs: [MusicPitch]) -> Bool {
        return lhs.notes == rhs
    }
    

}
