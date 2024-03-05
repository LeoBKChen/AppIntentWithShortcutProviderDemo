//
//  ItemShortcutEntity.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/23.
//

import Foundation
import AppIntents

struct ItemShortcutEntity: Identifiable, AppEntity {
    
    
    var id: UUID
    
    var title: String
    
    var timestamp: Date
    
    var status: [ItemStatus]
    
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Item")
    
    static var defaultQuery: ItemQuery = ItemQuery()
    
    var displayRepresentation: DisplayRepresentation {
        return DisplayRepresentation(
            title: "\(title)",
            subtitle: "",
            image: .init(systemName: "cube.box")
        )
    }
    
    struct ItemQuery: EntityStringQuery {
        func entities(matching title: String) async throws -> [ItemShortcutEntity] {
            
            return try await DataProvider.shared.getAllItems().filter {
                $0.title == title
            }.map {
                ItemShortcutEntity(
                    id: $0.id,
                    title: $0.title, 
                    timestamp: $0.timestamp,
                    status: $0.status
                )
            }
        }
        
        func entities(for identifiers: [UUID]) async throws -> [ItemShortcutEntity] {
            
            let items = try await DataProvider.shared.getAllItems().map {
                ItemShortcutEntity(
                    id: $0.id,
                    title: $0.title,
                    timestamp: $0.timestamp,
                    status: $0.status
                )
            }
            
            return identifiers.compactMap { id in
                items.first { $0.id == id }
            }
        }

        func suggestedEntities() async throws -> [ItemShortcutEntity] {
            try await DataProvider.shared.getAllItems().map {
                ItemShortcutEntity(
                    id: $0.id,
                    title: $0.title,
                    timestamp: $0.timestamp,
                    status: $0.status
                )
            }
        }
    }
    
}

extension ItemShortcutEntity: Hashable, Equatable {
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
    }
    
    // Equtable conformance
    static func ==(lhs: ItemShortcutEntity, rhs: ItemShortcutEntity) -> Bool {
        return lhs.id == rhs.id
    }
    
}
