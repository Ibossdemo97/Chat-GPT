//
//  ChatGPTApp.swift
//  ChatGPT
//
//  Created by Luyện Hà Luyện on 13/01/2023.
//

import SwiftUI

@main
struct ChatGPTApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
