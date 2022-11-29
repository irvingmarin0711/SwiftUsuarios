//
//  CrudUsuariosApp.swift
//  CrudUsuarios
//
//  Created by Lokura on 29/11/22.
//

import SwiftUI

@main
struct CrudUsuariosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
