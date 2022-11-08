//
//  OwnersViewModel.swift
//  mvvm
//
//  Created by Monika Piesyk on 18/10/2022.
//

import Foundation

class OwnersViewModel: NSObject{
    var items: [Owner] = []
    
    let ownersDataServices = OwnersDataService()
    static let screenTitle = NSLocalizedString("Owners", comment: "")
    
    override init() {
        super.init()
        fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reload),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
    }
    
    func fetchData() {
        items = ownersDataServices.savedEntities
    }
    
    func screenTitle() -> String {
        return OwnersViewModel.screenTitle
    }
    
    @objc func reload() {
        ownersDataServices.getOwners()
        fetchData()
    }
    
    func createOwnerCellModel(on index:IndexPath) -> OwnerTableViewCellModel {
        let owner = items[index.row]
        return OwnerTableViewCellModel(name: owner.name!, age: String(owner.age))
    }
    
    func owner(for index:IndexPath) -> Owner {
        return items[index.row]
    }
    
}

struct OwnerTableViewCellModel {
    var name: String
    var age: String
}
