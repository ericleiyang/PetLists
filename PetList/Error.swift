//
//  Error.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import Foundation

// MARK: - Error handler

struct Error {
    enum Code: Int {
        case URLError                 = -6000
        case NetworkRequestFailed     = -6001
        case JSONSerializationFailed  = -6002
        case JSONParsingFailed        = -6003
    }
    
    let errorCode: Code
}