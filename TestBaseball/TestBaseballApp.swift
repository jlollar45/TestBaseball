//
//  TestBaseballApp.swift
//  TestBaseball
//
//  Created by John Lollar on 7/29/22.
//

import SwiftUI

@main
struct TestBaseballApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
