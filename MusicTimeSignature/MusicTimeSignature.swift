//
//  MusicTimeSignature.swift
//  Music
//
//  Created by Mike Muszynski on 1/14/18.
//  Copyright © 2018 Mike Muszynski. All rights reserved.
//

import Foundation

public struct MusicTimeSignature {
    public var beats: Int
    public var baseRhythm: MusicRhythm
    
    public var numerator: Int {
        return beats
    }
    public var denominator: Int {
        switch baseRhythm {
        case .breve:
            return 0
        case .whole:
            return 1
        case .half:
            return 2
        case .quarter:
            return 4
        case .eighth:
            return 8
        case .sixteenth:
            return 16
        case .thirtysecond:
            return 32
        case .sixtyfourth:
            return 64
        case .dotted(_):
            fatalError("Dotted denominator is not yet supported")
        case .compound(_):
            fatalError("Compound denominator is not supported and likely will not be")
        }
    }
    
    public init(beats: Int, baseRhythm: MusicRhythm) {
        self.beats = beats
        self.baseRhythm = baseRhythm
    }
    
    ///Initializes a `MusicTimeSignature` from a given string in the form [number of beats]/[base rhythm] (e.g. 3/4)
    public init?(string: String) {
        let scanner = Scanner(string: string)
        scanner.charactersToBeSkipped = CharacterSet.decimalDigits.inverted
        
        //Get the number of beats
        var beats: Int = -1
        scanner.scanInt(&beats)
        guard beats > 0 else {
            return nil
        }
        
        var base: Int = -1
        scanner.scanInt(&base)
        guard let baseRhythmValue = MusicRhythm(baseDuration: 64 / base) else {
            return nil
        }
        
        self.beats = beats
        self.baseRhythm = baseRhythmValue
    }
    
    public static var common: MusicTimeSignature {
        return MusicTimeSignature(beats: 4, baseRhythm: .quarter)
    }
    
    public static var cut: MusicTimeSignature {
        return MusicTimeSignature(beats: 2, baseRhythm: .half)
    }
}

extension MusicTimeSignature: Equatable {
    public static func ==(lhs: MusicTimeSignature, rhs: MusicTimeSignature) -> Bool {
        return lhs.beats == rhs.beats && lhs.baseRhythm == rhs.baseRhythm
    }
}

// MARK: - Grouping Note Arrays
extension Array where Element == MusicNote {
    /// Attempts to group notes into measures returning nested arrays of `MusicNote`
    ///
    /// The array of `MusicNote` elements will be divided into further arrays containing the notes necessary to fill the entirety of the measure (or as much of the final measure as is possible with the remaining notes).
    ///
    /// As the method scans the notes in the original array, it may become necessary to split notes that will not fit in the remainder of the current measure. Thus, it is not guaranteed that the number of notes will remain consistent with the original array.
    ///
    /// - Parameter timeSignature: The `MusicTimeSignature` which defines the measure length
    /// - Returns: Array measures represented by `MusicNote` Arrays
    func groupedIntoMeasures(by timeSignature: MusicTimeSignature) -> [[MusicNote]] {
        var returnArray = [[MusicNote]]()
        let beatsPerMeasure = Double(timeSignature.beats)
        
        var currentMeasure = [MusicNote]()
        var currentMeasureBeats: Double = 0
        for note in self {
            let noteDuration = note.rhythm.duration(relativeTo: timeSignature.baseRhythm)
            if currentMeasureBeats == beatsPerMeasure {
                returnArray.append(currentMeasure)
                currentMeasure = [MusicNote]()
            }
            
            if currentMeasureBeats + noteDuration <= beatsPerMeasure {
                currentMeasure.append(note)
                currentMeasureBeats += noteDuration
            } else {
                
            }
        }
        
        return returnArray
    }
}
