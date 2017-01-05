//
//  MusicInterval.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 12/20/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicIntervalQuality {
    case perfect, major, minor, diminshed, augmented
}

public enum MusicIntervalQuantity: Int {
    case unison = 0, second, third, fourth, fifth, sixth, seventh, octave, ninth, tenth, eleventh, twelfth, thirteenth, fourteenth, fifteenth
}

public struct MusicInterval {
    ///The root pitch of the interval, described as a `MusicPitch`.
    var rootPitch: MusicPitch
        
    ///The quality of the interval, described as a `MusicIntervalQuality` type.
    var quality: MusicIntervalQuality
    
    ///The quantity of the interval, described as a `MusicIntervalQuantity` type.
    var quantity: MusicIntervalQuantity
    
    ///The `Range<MusicNote>` defined by this interval
    var range: Range<MusicPitch>
}
