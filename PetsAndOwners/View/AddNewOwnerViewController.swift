//
//  AddNewOwnerViewController.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 28/10/2022.
//

import Foundation
import UIKit

class AddNewOwnerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
 
    @IBOutlet weak var tableView:UITableView!
    
    var viewModel: AddNewOwnerViewModel!
    var delegate: ParentViewControllerProtocol?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = AddNewOwnerViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.showEmptyFieldAlert),
                                               name: NSNotification.Name(rawValue: "emptyFieldNotification"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showIncorrectAgeFieldAlert),
                                               name: NSNotification.Name(rawValue: "incorrectAgeFieldNotification"),
                                               object: nil)
        
        title = viewModel.screenTitle()
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        if viewModel.save() {
            delegate?.reloadData()
            dismiss(animated: true)
        }
    }
    
    @objc func showEmptyFieldAlert() {
        let alertModel = viewModel.emptyFieldAlertModel()
        let alertController = AlertBuilder.buildAlertController(with: alertModel)
        present(alertController, animated: true)
    }
    
    @objc func showIncorrectAgeFieldAlert() {
        let alertModel = viewModel.incorrectAgeFieldAlertModel()
        let alertController = AlertBuilder.buildAlertController(with: alertModel)
        present(alertController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewOwnerTableViewCell", for: indexPath) as! AddNewOwnerTableViewCell
        let cellViewModel: AddNewOwnerTableViewCellModel
        if indexPath.row == 0 {
            cellViewModel = viewModel.createmNameCellModel()
            cell.cellViewModel = cellViewModel
        } else if indexPath.row == 1 {
            cellViewModel = viewModel.createAgeCellModel()
            cell.cellViewModel = cellViewModel
        }
        cell.valueTextField.delegate = self
        return cell
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if textField.tag == 0 {
            return  viewModel.updateNameValue(name: updatedString )
            
        } else if textField.tag == 1 {
            return viewModel.updateAgeValue(age: updatedString)
        }
        return true
    }
}
