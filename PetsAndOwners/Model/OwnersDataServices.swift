//
//  OwnersDataService.swift
//  mvvm
//
//  Created by Monika Piesyk on 28/10/2022.
//

import Foundation
import CoreData

class OwnersDataService {
    
    static let containerName: String = "PetsAndOwners"
    static let entityName: String = "Owner"
    @Published var savedEntities: [Owner] = []
    private var context: NSManagedObjectContext
    static private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: OwnersDataService.containerName)
        container.loadPersistentStores { description, error in
            if let error = error {
                 fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    init() {
        self.context = OwnersDataService.persistentContainer.viewContext
        self.getOwners()
    }
    
    func getOwners() {
        let request = NSFetchRequest<Owner>(entityName: OwnersDataService.entityName)
        do {
            savedEntities = try context.fetch(request)
        
        } catch let error {
            print("Fetching error \(error)")
        }
    }
    
    func getData(for owner:Owner) -> Owner? {
        let request = NSFetchRequest<Owner>(entityName: OwnersDataService.entityName)
        request.predicate = NSPredicate(format: "name == %@", owner.name!)
        do {
            let resultArray = try context.fetch(request)
            return resultArray[0]
        
        } catch let error {
            print("Fetching error \(error)")
            return nil
        }
    }
    
    func saveNewOwner(name:String, age:Int16) {
        let owner = Owner(context: context)
        owner.name = name
        owner.age = age
        save()
    }
    
    func addNewPet(pet:Pet, for owner:Owner) {
        var petsArray: [Pet]
        if let array = JsonConverter.convertedJsonToArray(jsonText: owner.pets) {
            petsArray = array
            petsArray.append(pet)
        } else {
            petsArray = [pet]
        }
        owner.pets = JsonConverter.convertedArrayToJson(array: petsArray)
        save()
    }
    
    private func save() {
        do {
            try context.save()
        } catch let error {
            print("Saving error \(error)")
        }
    }
    
   
}

