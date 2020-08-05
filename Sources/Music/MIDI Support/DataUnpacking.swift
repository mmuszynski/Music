//
//  DataUnpacking.swift
//  Music
//
//  Created by Mike Muszynski on 1/6/18.
//  Copyright © 2018 Mike Muszynski. All rights reserved.
//

import Foundation

public extension Data {
    func decode<T>(_ type: T.Type) throws -> T {
        guard let returnVal = self.withUnsafeBytes({ (rawPointer) -> T? in
            return rawPointer.load(as: T.self)
        }) else {
            throw MIDIDecodeError.errorUnpackingValue
        }
        return returnVal
    }
    
    func decodeString(encoding: String.Encoding) throws -> String {
        guard let string = String(bytes: self, encoding: encoding) else {
            throw MIDIDecodeError.errorUnpackingValue
        }
        return string
    }
    
    var hexString: String {
        return self.map({ String(format: "%02hhx", $0) }).joined()
    }
}
