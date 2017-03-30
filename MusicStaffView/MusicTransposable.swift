//
//  Transposable.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/30/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation


/// Protocol describing an entity that can be transposed.
///
/// Structs and classes adopting this protocol need only provide `transposed(by interval: MusicIntervalTriple)`, as the protocol will infer that this is the same transposition used in the mutating verion `transpose(by interval: MusicIntervalTriple)`
protocol MusicTransposable {
    mutating func transpose(by interval: MusicIntervalTriple) throws
    func transposed(by interval: MusicIntervalTriple) throws -> Self
}

extension MusicTransposable {
    mutating func transpose(by interval: MusicIntervalTriple) throws {
        self = try self.transposed(by: interval)
    }
}
