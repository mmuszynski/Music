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
        switch self {
        case .majorTriad:
            return [(.upward, .major, .third),
                    (.upward, .minor, .third)].map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .minorTriad:
            return [(.upward, .minor, .third),
                    (.upward, .major, .third)].map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .augmentedTriad:
            return [(.upward, .major, .third),
                    (.upward, .major, .third)].map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .diminishedTriad:
            return [(.upward, .minor, .third),
                    (.upward, .minor, .third)].map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .majorSeventh:
            return [(.upward, .major, .third),
                    (.upward, .minor, .third),
                    (.upward, .major, .third)].map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .dominantSeventh:
            return [(.upward, .major, .third),
                    (.upward, .minor, .third),
                    (.upward, .minor, .third)].map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .minorSeventh:
            return [(.upward, .minor, .third),
                    (.upward, .major, .third),
                    (.upward, .minor, .third)].map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .halfDiminishedSeventh:
            return [(.upward, .minor, .third),
                    (.upward, .minor, .third),
                    (.upward, .major, .third)].map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .fullyDiminishedSeventh:
            return [(.upward, .minor, .third),
                    (.upward, .minor, .third),
                    (.upward, .minor, .third)].map { try! MusicInterval(direction: $0.0, quality: $0.1, quantity: $0.2) }
        case .generic(let intervals):
            return intervals
        }
    }
}
