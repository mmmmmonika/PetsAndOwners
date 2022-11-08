//
//  OwnerTableViewCell.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 31/10/2022.
//

import Foundation
import UIKit

class OwnerTableViewCell:UITableViewCell {
    
    var cellViewModel: OwnerTableViewCellModel? {
            didSet {
                textLabel?.text = cellViewModel?.name
                detailTextLabel?.text = cellViewModel?.age
            }
    }
}
