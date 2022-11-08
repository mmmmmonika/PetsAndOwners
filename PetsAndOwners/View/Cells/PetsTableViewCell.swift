//
//  PetsTableViewCell.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 31/10/2022.
//

import Foundation
import UIKit

class PetsTableViewCell:UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var petsViewModel: PetsTableViewCellModel? {
            didSet {
                nameLabel?.text = petsViewModel?.name
                nameLabel?.textColor = petsViewModel?.textColor
                if let _image = petsViewModel?.image {
                    iconImageView.image = UIImage(named: _image)
                } 
            }
    }
}
