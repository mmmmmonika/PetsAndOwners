//
//  ContentView.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 28/10/2022.
//

import SwiftUI
import CoreData
import UIKit

struct ContentView: View {
    var body: some View {
        PetsApp()
    }
}

struct PetsApp: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "OwnersViewController", bundle:Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "OwnersNavigationViewController")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
