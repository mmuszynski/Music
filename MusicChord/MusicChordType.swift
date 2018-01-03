//
//  MusicChordMode.swift
//  Music
//
//  Created by Mike Muszynski on 3/31/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public enum MusicChordType: MusicIntervalRepresentable {
    case majorTriad, minorTriad, augmentedTriad, diminishedTriad
    case majorSeventh, dominantSeventh, minorSeventh, halfDiminishedSeventh, fullyDiminishedSeventh
    case generic(intervals: [MusicInterval])
    
    public static func genericType(fromNotes notes: [MusicPitch]) throws -> MusicChordType {
        let ordered = notes.sorted()
        var intervals = [MusicInterval]()
        let root = ordered.first!
        for i in 0..<ordered.count-1 {
            let interval = try MusicInterval(rootPitch: root, destinationPitch: ordered[i+1])
            intervals.append(interval)
        }
        return MusicChordType.generic(intervals: intervals)
    }
    
    public var intervalDescription: [MusicInterval] {
        func tripletToInterval(triplet: (MusicIntervalDirection, MusicIntervalQuality, MusicIntervalQuantity)) -> MusicInterval {
            return try! MusicInterval(direction: triplet.0, quality: triplet.1, quantity: triplet.2)
        }
        
        switch self {
        case .majorTriad:
            return [(.upward, .major, .third),
                    (.upward, .perfect, .fifth)].map(tripletToInterval)
        case .minorTriad:
            return [(.upward, .minor, .third),
                    (.upward, .perfect, .fifth)].map(tripletToInterval)
        case .augmentedTriad:
            return [(.upward, .major, .third),
                    (.upward, .augmented, .fifth)].map(tripletToInterval)
        case .diminishedTriad:
            return [(.upward, .minor, .third),
                    (.upward, .diminished, .fifth)].map(tripletToInterval)
        case .majorSeventh:
            return [(.upward, .major, .third),
                    (.upward, .perfect, .fifth),
                    (.upward, .major, .seventh)].map(tripletToInterval)
        case .dominantSeventh:
            return [(.upward, .major, .third),
                    (.upward, .perfect, .fifth),
                    (.upward, .minor, .seventh)].map(tripletToInterval)
        case .minorSeventh:
            return [(.upward, .minor, .third),
                    (.upward, .perfect, .fifth),
                    (.upward, .minor, .seventh)].map(tripletToInterval)
        case .halfDiminishedSeventh:
            return [(.upward, .minor, .third),
                    (.upward, .diminished, .fifth),
                    (.upward, .minor, .seventh)].map(tripletToInterval)
        case .fullyDiminishedSeventh:
            return [(.upward, .minor, .third),
                    (.upward, .diminished, .fifth),
                    (.upward, .diminished, .seventh)].map(tripletToInterval)
        case .generic(let intervals):
            return intervals
        }
    }
}
