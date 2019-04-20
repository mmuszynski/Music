//
//  MusicNote+Hashable.swift
//  Music
//
//  Created by Mike Muszynski on 1/3/18.
//  Copyright © 2018 Mike Muszynski. All rights reserved.
//

import Foundation

extension MusicNote: Hashable {
    private func isEquivalent(to note: MusicNote) -> Bool {
        if self.pitch != note.pitch {
            return false
        } else if self.rhythm != note.rhythm {
            return false
        }
        
        return true
    }
    
    private func isEnharmonicallyEquivalent(to otherNote: MusicNote) -> Bool {
        return self.pitch.isEnharmonicEquivalent(of: otherNote.pitch)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(pitch)
        hasher.combine(rhythm)
    }
    
    //Equatable
    public static func ==(lhs: MusicNote, rhs: MusicNote) -> Bool {
        return lhs.isEquivalent(to: rhs)
    }
    
    //Comparable
}
