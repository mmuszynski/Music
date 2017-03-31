//
//  MusicChordTests.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/31/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import MusicStaffView

class MusicChordTests: XCTestCase {
    
    func testChordCreation() {
        let C0 = MusicPitch(name: .c, accidental: .natural, octave: 0)
        let cMajorTriad = MusicChord(rootNote: C0, mode: .major, type: .triad)
    }
    
}
