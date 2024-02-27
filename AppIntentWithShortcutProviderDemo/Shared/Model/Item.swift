//
//  Item.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/22.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    @Attribute(.unique) var id: UUID
    
    var title: String
    
    var status: [ItemStatus]
    
    init(timestamp: Date, id: UUID, title: String? = nil, status: [ItemStatus]) {
        self.timestamp = timestamp
        self.id = id
        
        if let title = title {
            self.title = title
        }
        else {
            self.title = id.uuidString
        }
        
        self.status = status
    }
    
    func cover(with item: Item) {
        self.timestamp = item.timestamp
        self.status = item.status
        self.id = item.id
    }
    
    func cover(with item: ItemShortcutEntity) {
        self.timestamp = item.timestamp
        self.status = item.status
        self.id = item.id
    }
}
