//
//  AddNewOwnerViewModel.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 28/10/2022.
//

import Foundation
import UIKit

class AddNewOwnerViewModel: NSObject {
    static let numberOfCells = 2
    static let screenTitle = NSLocalizedString("New Owner", comment: "Owners VC Title")
    static let nameCellTitle = NSLocalizedString("Name", comment: "New Owner name")
    static let ageCellTitle = NSLocalizedString("Age", comment: "New Owner age")
    static let alertTitle = NSLocalizedString("Warning", comment: "Alert title")
    static let alertEmptyFieldMessage = NSLocalizedString("Some field is empty", comment: "Empty field alert")
    
    static let alertIncorrectAgeFieldMessage = NSLocalizedString("Incorrect age", comment: "Age is higher than 120")
    static let alertOkButton = NSLocalizedString("OK", comment: "Ok button")
    static let maxAge:Int16 = 120
    
    var ownersDataServices: OwnersDataService?
    private var showAlertObserver: NSObjectProtocol?
    
    private var newOwnerName: String?
    private var newOwnerAge: Int16?
    
    override init() {
        super.init()
    }
    
    func numberOfCells() -> Int {
        return AddNewOwnerViewModel.numberOfCells
    }
    
    func screenTitle() -> String {
        return AddNewOwnerViewModel.screenTitle
    }
    
    func createmNameCellModel() -> AddNewOwnerTableViewCellModel {
        return AddNewOwnerTableViewCellModel(title: AddNewOwnerViewModel.nameCellTitle, keyboardType:UIKeyboardType.default, textFieldTag: 0)
    }
    
    func createAgeCellModel() -> AddNewOwnerTableViewCellModel {
        return AddNewOwnerTableViewCellModel(title: AddNewOwnerViewModel.ageCellTitle, keyboardType:UIKeyboardType.numberPad, textFieldTag:1)
    }
    
    func save() -> Bool {
        guard let _newOwnerName = newOwnerName,
              let _newOwnerAge = newOwnerAge else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "emptyFieldNotification"), object: nil)
                return false
        }
        if _newOwnerAge > AddNewOwnerViewModel.maxAge {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "incorrectAgeFieldNotification"), object: nil)
            return false
        }
        ownersDataServices?.saveNewOwner(name: _newOwnerName, age: _newOwnerAge)
        return true
    }
    
    func emptyFieldAlertModel () -> AlertModel {
        return AlertModel(title: AddNewOwnerViewModel.alertTitle,
                                message: AddNewOwnerViewModel.alertEmptyFieldMessage,
                        prefferedStyle: UIAlertController.Style.alert)
    }
    
    func incorrectAgeFieldAlertModel () -> AlertModel {
        return AlertModel(title: AddNewOwnerViewModel.alertTitle,
                                message: AddNewOwnerViewModel.alertIncorrectAgeFieldMessage,
                        prefferedStyle: UIAlertController.Style.alert)
    }
    
    func updateNameValue(name:String?) -> Bool{
        newOwnerName = name
        return true
    }
    
    func updateAgeValue(age:String?)-> Bool {
        guard let age = Int16(age!) else {
            return false
        }
        newOwnerAge = age
        return true
    }
}

struct AddNewOwnerTableViewCellModel {
    var title: String
    var keyboardType: UIKeyboardType
    var textFieldTag: Int
}

struct AlertModel {
    var title: String
    var message: String
    var prefferedStyle: UIAlertController.Style
}
