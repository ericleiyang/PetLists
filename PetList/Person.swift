//
//  Person.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Person {
    
    // MARK: Properties
    
    let name: String
    let gender: String
    let age: Int
    let pets: [Pet]
    
    // MARK: Init with json
    
    static func initWithJSON(json: JSON, pets: [Pet]) -> Person? {
        
        guard let name = json["name"].string,
            gender = json["gender"].string,
            age = json["age"].int else {
                return nil
        }
        
        let person = Person(name: name, gender: gender, age: age, pets: pets)
        
        return person
    }
}
