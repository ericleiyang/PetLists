//
//  PeopleViewModel.swift
//  PetList
//
//  Created by EricYang on 27/09/2016.
//  Copyright © 2016 EricYang. All rights reserved.
//

import Foundation

class DashboardViewModel {
    // MARK: - Constants
    
    private let emptyString = ""
    
    // MARK: - Properties
    
    let hasError: Observable<Bool>
    let errorMessage: Observable<String?>
    
    let petsByOwnerGenderDict: Observable<[String: [PetViewModel]]>
    
    // MARK: - Services
    
    private var apiService: APIService
    
    // MARK: - init
    
    init() {
        hasError = Observable(false)
        errorMessage = Observable(nil)
        
        petsByOwnerGenderDict = Observable([:])
        
        // Can put Dependency Injection here
        apiService = APIService()
    }
    
    // MARK: - public
    
    func startAPIService() {
        apiService.retrievePeopleInfo([:]) { (persons, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if let unwrappedError = error {
                    print(unwrappedError)
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedPersons = persons else {
                    return
                }
                self.update(unwrappedPersons)
            })
        }

    }
    
    // MARK: - private
    
    private func update(persons: [Person]) {
        hasError.value = false
        errorMessage.value = nil

        var tempDict = [String: [PetViewModel]]()
        
        var petViewModelsMale = [PetViewModel]()
        var petViewModelsFemale = [PetViewModel]()

        for person in persons{
            
            let personViewModel = PersonViewModel(person: person)
            
            if person.gender == "Male" {
                petViewModelsMale.appendContentsOf(personViewModel.pets.value)
                tempDict["Male"] = petViewModelsMale
            }else if person.gender == "Female"{
                petViewModelsFemale.appendContentsOf(personViewModel.pets.value)
                tempDict["Female"] = petViewModelsFemale
            }
        }
        
        tempDict["Male"] = self.getSortedPets(tempDict["Male"]!)
        tempDict["Female"] = self.getSortedPets(tempDict["Female"]!)

        self.petsByOwnerGenderDict.value = tempDict
    }
    
    // Sort array by name
    private func getSortedPets(pets: [PetViewModel]) -> [PetViewModel]{
        return pets.sort{ $0.name.value < $1.name.value}
    }
    
    // Error message can be handled here
    private func update(error: Error) {
        hasError.value = true
        
        switch error.errorCode {
        case .URLError:
            errorMessage.value = "The API service is not working."
        case .NetworkRequestFailed:
            errorMessage.value = "The network appears to be down."
        case .JSONSerializationFailed:
            errorMessage.value = "We're having trouble processing data."
        case .JSONParsingFailed:
            errorMessage.value = "We're having trouble parsing data."
        }
        
        self.petsByOwnerGenderDict.value = [String: [PetViewModel]]()
    }
}
