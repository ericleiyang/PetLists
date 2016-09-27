//
//  PersonViewModel.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import Foundation

class PersonViewModel {
    
    // MARK: Observable properties

    let gender: Observable<String>
    let pets: Observable<[PetViewModel]>
    
    // MARK: - init
    
    init(person: Person) {
        gender = Observable(person.gender)
        pets = Observable([])
        pets.value = person.pets.map { pet in
            return PetViewModel(pet: pet)
        }
    }
}