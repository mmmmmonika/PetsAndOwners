//
//  AddNewOwnerTableViewCell.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 28/10/2022.
//

import Foundation
import UIKit

class AddNewOwnerTableViewCell:UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var valueTextField:UITextField!
    
    var cellViewModel: AddNewOwnerTableViewCellModel? {
            didSet {
                titleLabel.text = cellViewModel?.title
                valueTextField.keyboardType = cellViewModel?.keyboardType ?? UIKeyboardType.default
                valueTextField.tag = cellViewModel?.textFieldTag ?? 0
            }
    }
}
