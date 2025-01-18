//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Havells on 18/01/25.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            Onboarding()
        }
    }
}
