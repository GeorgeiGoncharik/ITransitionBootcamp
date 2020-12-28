//
//  DailyeApp.swift
//  Dailye
//
//  Created by Mac on 29.12.20.
//

import SwiftUI

@main
struct DailyeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
