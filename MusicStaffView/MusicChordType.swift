//
//  MusicChordMode.swift
//  MusicStaffView
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
        for i in 0..<ordered.count-1 {
            let interval = try MusicInterval(rootPitch: ordered[i], destinationPitch: ordered[i+1])
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
                    (.upward, .minor, .third)].map(tripletToInterval)
        case .minorTriad:
            return [(.upward, .minor, .third),
                    (.upward, .major, .third)].map(tripletToInterval)
        case .augmentedTriad:
            return [(.upward, .major, .third),
                    (.upward, .major, .third)].map(tripletToInterval)
        case .diminishedTriad:
            return [(.upward, .minor, .third),
                    (.upward, .minor, .third)].map(tripletToInterval)
        case .majorSeventh:
            return [(.upward, .major, .third),
                    (.upward, .minor, .third),
                    (.upward, .major, .third)].map(tripletToInterval)
        case .dominantSeventh:
            return [(.upward, .major, .third),
                    (.upward, .minor, .third),
                    (.upward, .minor, .third)].map(tripletToInterval)
        case .minorSeventh:
            return [(.upward, .minor, .third),
                    (.upward, .major, .third),
                    (.upward, .minor, .third)].map(tripletToInterval)
        case .halfDiminishedSeventh:
            return [(.upward, .minor, .third),
                    (.upward, .minor, .third),
                    (.upward, .major, .third)].map(tripletToInterval)
        case .fullyDiminishedSeventh:
            return [(.upward, .minor, .third),
                    (.upward, .minor, .third),
                    (.upward, .minor, .third)].map(tripletToInterval)
        case .generic(let intervals):
            return intervals
        }
    }
}
