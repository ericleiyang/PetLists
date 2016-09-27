//
//  Pet.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Pet {
    
    // MARK: Properties

    let name: String
    let type: String
    
    // MARK: Init with json

    static func initWithJSON(json: JSON) -> Pet? {
        
        guard let name = json["name"].string,
            type = json["type"].string else {
                return nil
        }
        
        let pet = Pet(name: name, type: type)
        
        return pet
    }
}