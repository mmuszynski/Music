//
//  MusicChord.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/31/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public struct MusicChord: MusicPitchCollection {
    internal var pitches: [_Element] = []
    public typealias _Element = MusicPitch
    
    public var type: MusicChordType
    public var root: MusicPitch
    
    public init(root: MusicPitch, type: MusicChordType) throws {
        self.type = type
        self.root = root
        self.pitches = try type.pitches(from: root)
    }
    
    internal init(pitches: [MusicPitch]) {
        self.pitches = pitches.sorted()
        self.root = pitches.first!
        self.type = try! MusicChordType.genericType(fromNotes: self.pitches)
    }
    
    public static func ==(lhs: MusicChord, rhs: [MusicPitch]) -> Bool {
        return lhs.pitches == rhs
    }
    
}
