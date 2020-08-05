//
//  MusicPitch.swift
//  Music
//
//  Created by Mike Muszynski on 8/5/20.
//  Copyright © 2020 Mike Muszynski. All rights reserved.
//

import Foundation


extension MusicPitch {
    
    static let midiKeyOffsetToEnharmahomicIndex: Int = 12
    
    var midiKey: UInt8 {
        return UInt8(self.enharmonicIndex + MusicPitch.midiKeyOffsetToEnharmahomicIndex)
    }
    
    private func enharmonicIndex(from midiKey: UInt8) -> Int {
        return Int(midiKey) - MusicPitch.midiKeyOffsetToEnharmahomicIndex
    }
    
    /// Initializes a pitch from a specific MIDI key value
    ///
    /// MIDI stores pitch values enharmonically (e.g. there is no distinction between E and F Flat).
    ///
    /// - Parameters:
    ///   - midiKey: The `UInt8` value that describes the pitch in MIDI
    ///   - keySignature: The desired key signature
    @available(*, unavailable)
    init?(midiKey: UInt8, in keySignature: MusicKeySignature) {
        let accidentals = MusicAccidental.allCases
        let potential = accidentals.compactMap({ MusicPitch(midiKey: midiKey, accidental: $0) })
        
        guard let pitch = potential.filter({ keySignature.pitches.contains(MusicPitchAccidental(name: $0.name, accidental: $0.accidental)) }).first else {
            return nil
        }
        self = pitch
    }
    
    /// Initializes a `MusicPitch` given a specific MIDI key value and `MusicAccidental`.
    ///
    /// - note: Returns nil if a suitable note cannot be constructed (e.g. E natural cannot be spelled enharmonically via a sharp)
    ///
    /// - Parameters:
    ///   - midiKey: The `UInt8` value that describes the pitch in MIDI
    ///   - accidental: The desired accidental
    init?(midiKey: UInt8, accidental: MusicAccidental) {
        let index = enharmonicIndex(from: midiKey)
        guard let pitch = MusicPitch(enharmonicIndex: index, accidental: accidental) else { return nil }
        self = pitch
    }
    
    /// Initializes a `MusicPitch` given a specific MIDI key value and a preferred accidental
    ///
    /// Pitches in a key signature or chord will prefer to be spelled in a certain way. Since MIDI does not store data as to how enharmonics should be spelled, it needs a little bit of help.
    /// This initializer requires a preference of accidentals to be used, meaning that a valid way to spell the pitch will be found.
    ///
    /// - Parameters:
    ///   - midiKey: The `UInt8` value that describes the pitch in MIDI
    ///   - accidentalPreference: The preferred accidentals. If none are provided, a defaut list will be used.
    init(midiKey: UInt8, accidentalPreference: [MusicAccidental] = []) {
        let defaultOrder: [MusicAccidental] = [.natural, .flat, .sharp, .doubleFlat, .doubleSharp]
        var preference = accidentalPreference
        for accidental in defaultOrder {
            if !preference.contains(accidental) {
                preference.append(accidental)
            }
        }
        
        for accidental in preference {
            if let pitch = MusicPitch(midiKey: midiKey, accidental: accidental) {
                self = pitch
                return
            }
        }
    }
}
