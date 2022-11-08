//
//  OwnerDetailViewController.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 28/10/2022.
//

import Foundation
import UIKit

class OwnerDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ParentViewControllerProtocol {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    var viewModel: OwnerDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        if !isViewLoaded {
                return
        }
        guard let viewModel = viewModel else {
                return
        }
        title = viewModel.screenTitle()
        imageView.image = viewModel.setImage()
        nameLabel.text = viewModel.setName()
        ageLabel.text = viewModel.setAge()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = viewModel.pets?.count {
            return count + 1
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetTableViewCell", for: indexPath) as! PetsTableViewCell
        var cellViewModel: PetsTableViewCellModel
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cellViewModel = viewModel.prepareAddPetCellModel()
        } else {
            cellViewModel = viewModel.preparePetCellModel(at: indexPath)
        }
        
        cell.petsViewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1  {
            let storyboard = UIStoryboard(name: "OwnersViewController", bundle:Bundle.main)
            if let controller = storyboard.instantiateViewController(withIdentifier: "PetsCollectionViewController") as? PetsCollectionViewController {
                controller.delegate = self
                modalPresentationStyle = .fullScreen
                present(controller, animated: true)
                    controller.viewModel = PetsCollectionViewModel(_owner: viewModel.owner)
            }
        } else {
            
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
