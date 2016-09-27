//
//  Router.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import Foundation

// MARK: A CRUD method protocol for object

protocol Router{
    func createObjectPath()-> String
    func readObjectPath(parameters: NSDictionary)-> String
    func updateObjectPath(identifier: String)-> String
    func deleteObjectPath(identifier: String)-> String
}

extension Router{
    func createObjectPath()-> String{
        return ""
    }
    func readObjectPath(parameters: NSDictionary)-> String{
        return ""
    }
    func updateObjectPath(identifier: String)-> String{
        return ""
    }
    func deleteObjectPath(identifier: String)-> String{
        return ""
    }
}