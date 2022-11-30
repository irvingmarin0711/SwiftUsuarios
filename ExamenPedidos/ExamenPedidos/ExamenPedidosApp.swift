//
//  ExamenPedidosApp.swift
//  ExamenPedidos
//
//  Created by Lokura on 29/11/22.
//

import SwiftUI

@main
struct ExamenPedidosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
