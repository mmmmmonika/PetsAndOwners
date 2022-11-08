//
//  PetCollectionViewCell.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 31/10/2022.
//

import Foundation
import UIKit

class PetCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView:UIImageView!
    
    var petsViewModel: PetCollectionViewCellModel? {
            didSet {
                imageView?.image = petsViewModel?.image
            }
    }
}
