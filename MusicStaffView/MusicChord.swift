//
//  MusicChord.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/31/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public struct MusicChord: MusicPitchCollection {
    internal var notes: [_Element] = []
    public typealias _Element = MusicPitch
    
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
