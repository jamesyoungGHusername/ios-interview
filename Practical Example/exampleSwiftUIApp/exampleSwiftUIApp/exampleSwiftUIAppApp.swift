//
//  exampleSwiftUIAppApp.swift
//  exampleSwiftUIApp
//
//  Created by James Young on 7/9/22.
//

import SwiftUI

@main
struct exampleSwiftUIAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
