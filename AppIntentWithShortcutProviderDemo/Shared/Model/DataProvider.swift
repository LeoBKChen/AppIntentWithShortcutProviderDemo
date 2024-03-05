//
//  SwiftDataContainer.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/23.
//

import SwiftData
import Foundation
import AppIntents

enum Errors: Error {
    case ITEM_NOT_EXISTS
    case UPDATE_ITEM_FAIL
}

protocol ItemDataController {
    func getAllItems() throws -> [Item]
    func getItem(with name: String) throws -> Item
    func insertItem(_ item: Item)
    func updateItem(_ item: Item) throws
    func updateItem(_ item: ItemShortcutEntity) throws
    func deleteItem(_ item: Item) throws
}

class DataProvider {
    static let shared = DataProvider()
    
    let container: ModelContainer
    
    init () {
        
        let schema = Schema([
            Item.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            self.container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
        ShortcutsProvider.updateAppShortcutParameters()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateShortcutProvider(_:)),
            name: Notification.Name.NSManagedObjectContextObjectsDidChange,
            object: nil
        )
    
    }
    
    @objc func updateShortcutProvider(_ notification: NSNotification) {
        ShortcutsProvider.updateAppShortcutParameters()
    }
}

extension DataProvider: ItemDataController {
    @MainActor
    func getAllItems() throws -> [Item] {
        let context = self.container.mainContext
        
        let upcomingItems = FetchDescriptor<Item>()

        return try context.fetch(upcomingItems)
    }
    
    @MainActor
    func updateItem(_ item: Item) throws {
        let originalItem = try self.getItem(with: item.title)
        originalItem.cover(with: item)
    }
    
    @MainActor
    func updateItem(_ item: ItemShortcutEntity) throws {
        let originalItem = try self.getItem(with: item.title)
        originalItem.cover(with: item)
    }
    
    @MainActor
    func deleteItem(_ item: Item) throws {
        let context = self.container.mainContext
        
        let originalItem = try self.getItem(with: item.title)
        context.delete(originalItem)
    }
    
    @MainActor
    func insertItem(_ item: Item) {
        let context = self.container.mainContext
        
        context.insert(item)
        try? context.save()
    }
    
    @MainActor
    func getItem(with title: String) throws -> Item {
        let context = self.container.mainContext
        
        var upcomingItem = FetchDescriptor<Item>(
            predicate: #Predicate { $0.title == title }
        )
        
        upcomingItem.fetchLimit = 1
        
        if let item = try context.fetch(upcomingItem).first {
            return item
        }
        else {
            throw Errors.ITEM_NOT_EXISTS
        }
    }
}
