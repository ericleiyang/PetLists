//
//  APIService.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CompletionHandler = ([Person]?, Error?) -> Void

struct APIService {
    
    // MARK: Public method

    func retrievePeopleInfo(parameters: NSDictionary, completionHandler: CompletionHandler) {
        
        let URLRequest = AlamofireRouter.ReadObject(PersonRouters(), parameters).URLRequest
        Alamofire.request(URLRequest)
            .response { request, response, data, error in
                
                // Check network error
                guard error == nil else {
                    let error = Error(errorCode: .NetworkRequestFailed)
                    completionHandler(nil, error)
                    return
                }
                
                // Check JSON serialization error
                guard let unwrappedData = data else {
                    let error = Error(errorCode: .JSONSerializationFailed)
                    completionHandler(nil, error)
                    return
                }
                
                let json = JSON(data: unwrappedData)
                
                completionHandler(self.getPersonsFromJSON(json), nil)
        }
    }
    
    // MARK: Private method

    //Create person object by json
    
    private func getPersonsFromJSON(json: JSON) -> [Person] {
        var persons: [Person] = []
        
        for (_, personJson):(String, JSON)  in json {
            
            guard let petJson = personJson["pets"].array else{
                continue
            }
            
            let pets = self.getPetsFromJSON(petJson)
            
            guard let person = Person.initWithJSON(personJson, pets: pets) else{
                break
            }
            
            persons.append(person)
        }
        
        return persons
    }
    
    //Create Pet object by json
    
    private func getPetsFromJSON(json: [JSON]) -> [Pet] {
        var pets: [Pet] = []
        
        for petJson in json {
            
            guard let pet = Pet.initWithJSON(petJson) else{
                continue
            }
            
            pets.append(pet)
        }
        
        return pets
    }
    
}
