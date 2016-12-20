//
//  MusicStaffViewTests.swift
//  MusicStaffViewTests
//
//  Created by Mike Muszynski on 9/30/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import XCTest
@testable import MusicStaffView

class MusicStaffViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNoteEquality() {
        let note1 = MusicNote(name: .a, accidental: .natural, length: .quarter, octave: 1)
        let note2 = MusicNote(name: .a, accidental: .natural, length: .quarter, octave: 1)
        XCTAssertEqual(note1, note2)
        
        note1.name = .b
        XCTAssertNotEqual(note1, note2)
        note2.name = .b
        XCTAssertEqual(note1, note2)
        
        note1.accidental = .none
        XCTAssertNotEqual(note1, note2)
        note2.accidental = .none
        XCTAssertEqual(note1, note2)

        
    }
    
    func testMajorScales() {
        
    }
    
    func testMinorScales() {
        
    }
    
}
