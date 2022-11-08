//
//  OwnersViewController.swift
//  mvvm
//
//  Created by Monika Piesyk on 18/10/2022.
//

import Foundation
import UIKit

class OwnersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ParentViewControllerProtocol {

    @IBOutlet weak var tableView:UITableView!
    
    var viewModel: OwnersViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OwnersViewModel()
        title = viewModel.screenTitle()
    }
 
    func reloadData() {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerTableViewCell", for: indexPath) as! OwnerTableViewCell
        let cellViewModel = viewModel.createOwnerCellModel(on: indexPath)
        cell.cellViewModel = cellViewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        
        if segue.identifier == "OwnersDetail",
           let indexPath = self.tableView.indexPathForSelectedRow,
           let ownerDetailViewController = segue.destination as? OwnerDetailViewController {
            ownerDetailViewController.viewModel = OwnerDetailViewModel(_owner: viewModel.owner(for: indexPath))
        } else if segue.identifier == "AddOwner",
                  let navigationController = segue.destination as? UINavigationController {
            if let addNewOwnerViewController = navigationController.topViewController as? AddNewOwnerViewController {
                addNewOwnerViewController.delegate = self
                addNewOwnerViewController.viewModel.ownersDataServices = viewModel.ownersDataServices
            }
        }
    }
}

protocol ParentViewControllerProtocol {
    func reloadData()
}


