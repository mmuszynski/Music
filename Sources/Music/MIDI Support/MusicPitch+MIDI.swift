//
//  MusicPitch.swift
//  Music
//
//  Created by Mike Muszynski on 8/5/20.
//  Copyright © 2020 Mike Muszynski. All rights reserved.
//

import Foundation


extension MusicPitch {
    
    static let midiKeyOffsetToEnharmahomicIndex: Int = 37
    
    var midiKey: UInt8 {
        return UInt8(self.enharmonicIndex + MusicPitch.midiKeyOffsetToEnharmahomicIndex)
    }
    
    init(midiKey: UInt8, in keySignature: MusicKeySignature) {
        let index = Int(midiKey) - MusicPitch.midiKeyOffsetToEnharmahomicIndex
        
}
