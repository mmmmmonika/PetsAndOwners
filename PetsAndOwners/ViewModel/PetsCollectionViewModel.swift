//
//  PetsCollectionViewModel.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 31/10/2022.
//

import Foundation
import UIKit

class PetsCollectionViewModel {
    
    let contentJson = """
                      [
                        {
                            "name": "Dog",
                            "petType": 0,
                            "image": "DogIcon"
                        },
                        {
                            "name":"Cat",
                            "petType": 1,
                            "image": "CatIcon"
                        },
                    ]
                    """
    var pets:[Pet] = []
    let owner: Owner
    let ownersDataServices = OwnersDataService()
    
    init( _owner:Owner) {
        owner = _owner
        if let _pets = JsonConverter.convertedJsonToArray(jsonText: contentJson) {
            pets = _pets
        }
    }
    
    func createPetCellModel(for indexPath:IndexPath) -> PetCollectionViewCellModel {
        let pet = pets[indexPath.row]
        return PetCollectionViewCellModel(image: UIImage(named: pet.image) ?? UIImage())
    }
    
    func addNewPet(pet:Pet) {
        ownersDataServices.addNewPet(pet: Pet(petType: pet.petType, name: pet.name, image: pet.image), for: owner)
    }
    
}

struct PetCollectionViewCellModel {
    let image: UIImage
}
