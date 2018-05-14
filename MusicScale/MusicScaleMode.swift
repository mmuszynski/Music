//
//  MusicScaleMode.swift
//  Music
//
//  Created by Mike Muszynski on 3/28/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

///Describes the mode of a music scale.
///
///A musical scale can be defined by its mode, which describes the relationships between the notes of the scale. For example, a major scale's pattern of half and whole steps (WWHWWWH) provides the blueprint for any major scale starting on any given note. These scales will all sound the same, only with different starting pitches.=
public enum MusicScaleMode: MusicIntervalRepresentable, MusicIntervalRepresentableDirectional {
    case major, harmonicMinor, naturalMinor, melodicMinor, majorPentatonic
    
    public var upwardIntervalDescription: [MusicInterval] {
        switch self {
        case .major:
            return ([(.upward, .major, .second),
                    (.upward, .major, .third),
                    (.upward, .perfect, .fourth),
                    (.upward, .perfect, .fifth),
                    (.upward, .major, .sixth),
                    (.upward, .major, .seventh),
                    (.upward, .perfect, .octave)] as [(MusicIntervalDirection, MusicIntervalQuality, MusicIntervalQuantity)]).map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .harmonicMinor:
            var alteredMajor = MusicScaleMode.major.upwardIntervalDescription
            alteredMajor[1] = try! MusicInterval(direction: .upward, quality: .minor, quantity: .third)
            alteredMajor[4] = try! MusicInterval(direction: .upward, quality: .minor, quantity: .sixth)
            return alteredMajor
        case .naturalMinor:
            var altered = MusicScaleMode.harmonicMinor.upwardIntervalDescription
            altered[5] = try! MusicInterval(direction: .upward, quality: .minor, quantity: .seventh)
            return altered
        case .melodicMinor:
            var alteredMajor = MusicScaleMode.major.upwardIntervalDescription
            alteredMajor[1] = try! MusicInterval(direction: .upward, quality: .minor, quantity: .third)
            return alteredMajor
        case .majorPentatonic:
            return ([(.upward, .major, .second),
                    (.upward, .major, .third),
                    (.upward, .perfect, .fifth),
                    (.upward, .major, .sixth)]  as [(MusicIntervalDirection, MusicIntervalQuality, MusicIntervalQuantity)]).map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        }
    }
    
    public var downwardIntervalDescription: [MusicInterval] {
        switch self {
        case .melodicMinor:
            return MusicScaleMode.naturalMinor.downwardIntervalDescription
        default:
            return self.upwardIntervalDescription.reversed()
        }
    }
}
