//
//  MusicClef+Equatable.swift
//  Music
//
//  Created by Mike Muszynski on 4/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

extension MusicClef: Equatable {
    func isEqual(to other: MusicClef) -> Bool {
        switch self {
        case .cClef(let offset):
            if case .cClef(let offset2) = other, offset == offset2 {
                return true
            }
        case .fClef(let offset):
            if case .fClef(let offset2) = other, offset == offset2 {
                return true
            }
        case .gClef(let offset):
            if case .gClef(let offset2) = other, offset == offset2 {
                return true
            }
        }
        return false
    }
    
    public static func ==(lhs: MusicClef, rhs: MusicClef) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}

extension MusicClef: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.centerLinePitch)
    }
}
