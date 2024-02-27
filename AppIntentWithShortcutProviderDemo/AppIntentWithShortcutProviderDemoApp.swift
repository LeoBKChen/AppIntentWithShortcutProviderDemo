//
//  AppIntentWithShortcutProviderDemoApp.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/22.
//

import SwiftUI
import SwiftData

@main
struct AppIntentWithShortcutProviderDemoApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(DataProvider.shared.container)
    }
}
