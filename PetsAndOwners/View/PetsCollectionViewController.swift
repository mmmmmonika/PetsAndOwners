//
//  PetsCollectionViewController.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 31/10/2022.
//

import Foundation
import UIKit

class PetsCollectionViewController: UICollectionViewController {
    
    var viewModel: PetsCollectionViewModel!
    var delegate: ParentViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.pets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCollectionViewCell", for: indexPath) as! PetCollectionViewCell
        
        let cellViewModel = viewModel.createPetCellModel(for: indexPath)
        cell.petsViewModel = cellViewModel
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let pet:Pet = viewModel.pets[indexPath.row]
        viewModel.addNewPet(pet:pet)
        delegate?.reloadData()
        dismiss(animated: true)
    }
}
