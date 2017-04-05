//
//  MusicKeySignaturePitch.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/4/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public struct MusicKeySignaturePitch: Equatable {
    var name: MusicPitchName
    var accidental: MusicPitchAccidental
    
    public static func ==(lhs: MusicKeySignaturePitch, rhs: MusicKeySignaturePitch) -> Bool {
        return lhs.name == rhs.name && lhs.accidental == rhs.accidental
    }
}
