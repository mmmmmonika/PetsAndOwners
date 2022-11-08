//
//  PetsViewModel.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 28/10/2022.
//

import Foundation
import UIKit

class OwnerDetailViewModel {
    static let screenTitle = NSLocalizedString("Owner Detail", comment: "Owner detail VC title")
    static let addPetCellTitle = NSLocalizedString("Add new pet", comment: "Add new pet cell titile")
    
    var owner: Owner
    var pets: [Pet]?
    
    init(_owner:Owner) {
        owner = _owner
        pets = JsonConverter.convertedJsonToArray(jsonText: owner.pets)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reload),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
    }
    
    @objc func reload() {
        let ownersDataServices = OwnersDataService()
        if let _owner = ownersDataServices.getData(for: owner) {
            owner = _owner
            pets = JsonConverter.convertedJsonToArray(jsonText: owner.pets)
        }
    }
    
    func screenTitle() -> String {
        return OwnerDetailViewModel.screenTitle
    }
    
    func setImage() -> UIImage {
        return owner.age > 18 ? UIImage(named: "AdultIcon")! : UIImage(named: "ChildIcon")!
    }
    
    func setName() -> String {
        return owner.name!
    }
    
    func setAge() -> String {
        let age = String(owner.age)
        return age
    }
    
    func prepareAddPetCellModel() -> PetsTableViewCellModel {
        return PetsTableViewCellModel(name: OwnerDetailViewModel.addPetCellTitle, image: nil, textColor: UIColor.blue)
    }
    
    func preparePetCellModel(at index: IndexPath) -> PetsTableViewCellModel {
       
        if let pet = pets?[index.row] {
            return PetsTableViewCellModel(name: pet.name, image: pet.image, textColor: UIColor.black)
        } else {
            print("Adding petcell error")
            return PetsTableViewCellModel(name: "", image: nil, textColor: UIColor.black)
        }
    }
}

struct PetsTableViewCellModel {
    let name: String
    let image: String?
    let textColor: UIColor
}
