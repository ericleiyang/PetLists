//
//  PersonRouters.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import Foundation

struct PersonRouters: Router {
    
    // MARK: subpath for the object

    let rootPath = "/people.json"
    
    
    // MARK: Init path with parameters

    func readObjectPath(parameters: NSDictionary) -> String {
        let urlString = urlWithComponents(parameters)
        return urlString!
    }
    
    // MARK: private

    private func urlWithComponents(parameters: NSDictionary) -> String?{
        
        guard let components = NSURLComponents(string:rootPath) else {
            return nil
        }
        
        //query parameters added here
//        components.queryItems = [NSURLQueryItem(name:"", value:""),
//                                 NSURLQueryItem(name:"", value:""),
//                                 NSURLQueryItem(name:"", value:"")]
        
        return components.URLString
    }
    
}
