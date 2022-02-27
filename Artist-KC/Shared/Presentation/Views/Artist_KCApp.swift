//
//  Artist_KCApp.swift
//  Artist-KC
//
//  Created by Guido Mola on 22/02/2022.
//

import SwiftUI

@main
struct Artist_KCApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
