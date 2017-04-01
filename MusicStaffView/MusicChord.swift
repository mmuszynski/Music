//
//  MusicChord.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/31/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public struct MusicChord: Collection {
    internal var notes: [_Element] = []
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
    
    public var type: MusicChordType
    public var root: MusicPitch
    
    public init(root: MusicPitch, type: MusicChordType) throws {
        self.type = type
        self.root = root
        self.notes = try type.pitches(from: root)
    }
    
    public static func ==(lhs: MusicChord, rhs: [MusicPitch]) -> Bool {
        return lhs.notes == rhs
    }
    
}
