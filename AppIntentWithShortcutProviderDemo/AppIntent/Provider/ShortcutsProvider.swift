//
//  AppShortcutsProvider.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/26.
//

import AppIntents

/// - Tag: AppShortcuts
struct ShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddItemIntent(),
            phrases: [
                "Add an item to\(.applicationName)",
            ],
            shortTitle: "Add Item",
            systemImageName: "plus.app"
        )
        AppShortcut(
            intent: ModifyItemIntent(),
            phrases: [
                "Modify an item in\(.applicationName)"
            ],
            shortTitle: "Modify Item",
            systemImageName: "rectangle.and.pencil.and.ellipsis"
        )
        AppShortcut(
            intent: ModifyItemIntent(.on),
            phrases: [
                "Turn on \(\.$item) in \(.applicationName)"
            ],
            shortTitle: "Turn on an item's status",
            systemImageName: "lightswitch.on"
        )
        AppShortcut(
            intent: ModifyItemIntent(.off),
            phrases: [
                "Turn off \(\.$item) in \(.applicationName)"
            ],
            shortTitle: "Turn off an item's status",
            systemImageName: "lightswitch.off.fill"
        )
    }
    static var shortcutTileColor: ShortcutTileColor = .blue
}
