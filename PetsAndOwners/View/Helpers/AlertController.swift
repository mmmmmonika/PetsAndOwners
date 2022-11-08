//
//  AlertController.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 28/10/2022.
//

import Foundation
import UIKit

class AlertBuilder{
    
    static func buildAlertController(with _model: AlertModel) -> UIAlertController {
        let controller = UIAlertController(title: _model.title, message: _model.message, preferredStyle: _model.prefferedStyle)
        controller.addAction(UIAlertAction(title: AddNewOwnerViewModel.alertOkButton, style: UIAlertAction.Style.default))
        
        return controller
    }
    
}
