//
//  MusicTimeSignatureTests.swift
//  MusicTests
//
//  Created by Mike Muszynski on 1/23/18.
//  Copyright © 2018 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import Music

class MusicTimeSignatureTests: XCTestCase {
    
    func testStringInit() {
        XCTAssertEqual(MusicTimeSignature(string: "3/4"), MusicTimeSignature(beats: 3, baseRhythm: .quarter))
        XCTAssertEqual(MusicTimeSignature(string: "2/4"), MusicTimeSignature(beats: 2, baseRhythm: .quarter))
        XCTAssertEqual(MusicTimeSignature(string: "5/8"), MusicTimeSignature(beats: 5, baseRhythm: .eighth))
        XCTAssertEqual(MusicTimeSignature(string: "12/8"), MusicTimeSignature(beats: 12, baseRhythm: .eighth))
        
        XCTAssertEqual(MusicTimeSignature(string: "2/2"), MusicTimeSignature.cut)
        XCTAssertEqual(MusicTimeSignature(string: "4/4"), MusicTimeSignature.common)
    }
    
}
