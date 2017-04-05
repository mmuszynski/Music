//
//  MusicKeySignature.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 12/20/16.
//  Copyright © 2016 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicKeySignature {
    case cMajor, fMajor, bFlatMajor, eFlatMajor, aFlatMajor, dFlatMajor, gFlatMajor, cFlatMajor
    case gMajor, dMajor, aMajor, eMajor, bMajor, fSharpMajor, cSharpMajor
    case aMinor, eMinor, bMinor, fSharpMinor, cSharpMinor, gSharpMinor, dSharpMinor, aSharpMinor
    case dMinor, gMinor, cMinor, fMinor, bFlatMinor, eFlatMinor, aFlatMinor
    
    public var pitches: [MusicKeySignaturePitch] {
        switch self {
        case .cMajor, .aMinor:
            return []
        case .fMajor, .dMinor:
            return Array(self.flats[0..<1])
        case .bFlatMajor, .gMinor:
            return Array(self.flats[0..<2])
        case .eFlatMajor, .cMinor:
            return Array(self.flats[0..<3])
        case .aFlatMajor, .fMinor:
            return Array(self.flats[0..<4])
        case .dFlatMajor, .bFlatMinor:
            return Array(self.flats[0..<5])
        case .gFlatMajor, .eFlatMinor:
            return Array(self.flats[0..<6])
        case .cFlatMajor, .aFlatMinor:
            return Array(self.flats[0..<7])
        case .gMajor, .eMinor:
            return Array(self.sharps[0..<1])
        case .dMajor, .bMinor:
            return Array(self.sharps[0..<2])
        case .aMajor, .fSharpMinor:
            return Array(self.sharps[0..<3])
        case .eMajor, .cSharpMinor:
            return Array(self.sharps[0..<4])
        case .bMajor, .gSharpMinor:
            return Array(self.sharps[0..<5])
        case .fSharpMajor, .dSharpMinor:
            return Array(self.sharps[0..<6])
        case .cSharpMajor, .aSharpMinor:
            return Array(self.sharps[0..<7])
        }
    }
    
    private var flats: [MusicKeySignaturePitch] {
        return [MusicKeySignaturePitch(name: .b, accidental: .flat),
                MusicKeySignaturePitch(name: .e, accidental: .flat),
                MusicKeySignaturePitch(name: .a, accidental: .flat),
                MusicKeySignaturePitch(name: .d, accidental: .flat),
                MusicKeySignaturePitch(name: .g, accidental: .flat),
                MusicKeySignaturePitch(name: .c, accidental: .flat),
                MusicKeySignaturePitch(name: .f, accidental: .flat)]
    }
    
    private var sharps: [MusicKeySignaturePitch] {
        return [MusicKeySignaturePitch(name: .f, accidental: .sharp),
                MusicKeySignaturePitch(name: .c, accidental: .sharp),
                MusicKeySignaturePitch(name: .g, accidental: .sharp),
                MusicKeySignaturePitch(name: .d, accidental: .sharp),
                MusicKeySignaturePitch(name: .a, accidental: .sharp),
                MusicKeySignaturePitch(name: .e, accidental: .sharp),
                MusicKeySignaturePitch(name: .b, accidental: .sharp)]
    }
}
