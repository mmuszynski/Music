//
//  MusicPitchAccidental.swift
//  Music
//
//  Created by Mike Muszynski on 4/4/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public struct MusicPitchAccidental: Equatable, Sendable {
    public let name: MusicPitchName
    public let accidental: MusicAccidental
    
    public static func ==(lhs: MusicPitchAccidental, rhs: MusicPitchAccidental) -> Bool {
        return lhs.name == rhs.name && lhs.accidental == rhs.accidental
    }
}
