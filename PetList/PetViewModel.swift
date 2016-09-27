//
//  PetViewModel.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import Foundation

class PetViewModel {

    // MARK: Observable properties
    
    let name: Observable<String>

    // MARK: - init
    
    init(pet: Pet) {
        name = Observable(pet.name)
    }
}