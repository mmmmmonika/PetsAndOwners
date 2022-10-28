//
//  PetsAndOwnersApp.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 28/10/2022.
//

import SwiftUI

@main
struct PetsAndOwnersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
