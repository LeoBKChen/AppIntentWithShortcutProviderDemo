//
//  ItemStatusIndexShortcutEntity.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/26.
//

import Foundation

import AppIntents

struct ItemStatusIndexShortcutEntity: Identifiable, AppEntity {
  
    struct ItemStatusIndexQuery: EnumerableEntityQuery {
        var indexNum: Int = 0
        
        func allEntities() async throws -> [ItemStatusIndexShortcutEntity] {
            var result: [ItemStatusIndexShortcutEntity] = []
            for i in 0..<self.indexNum {
                result.append(ItemStatusIndexShortcutEntity(
                    id: i,
                    statusIndex: i
                ))
            }
            
            return result
        }
        
        func entities(for identifiers: [Int]) async throws -> [ItemStatusIndexShortcutEntity] {
            return identifiers.compactMap { id in
                self.indexNum > id ? ItemStatusIndexShortcutEntity(id: id, statusIndex: id) : nil
            }
        }
        
        func suggestedEntities() async throws -> [ItemStatusIndexShortcutEntity] {
            var result: [ItemStatusIndexShortcutEntity] = []
            for i in 0..<self.indexNum {
                result.append(ItemStatusIndexShortcutEntity(
                    id: i,
                    statusIndex: i
                ))
            }
            
            return result
        }
    }

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Index")
    
    typealias DefaultQueryType = ItemStatusIndexQuery
    static var defaultQuery: ItemStatusIndexQuery = ItemStatusIndexQuery()
      
    var id: Int

    var statusIndex: Int
    
    var displayRepresentation: DisplayRepresentation {
        return DisplayRepresentation(
            title: "\(statusIndex)",
            subtitle: "",
            image: .init(systemName: "cube.box")
        )
    }
    
    init(id: Int, statusIndex: Int) {
        self.id = id
        self.statusIndex = statusIndex
    }
}
@available(iOS 16, *)
extension ItemStatusIndexShortcutEntity: Hashable, Equatable {
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
    }
    
    // Equtable conformance
    static func ==(lhs: ItemStatusIndexShortcutEntity, rhs: ItemStatusIndexShortcutEntity) -> Bool {
        return lhs.id == rhs.id
    }
    
}
