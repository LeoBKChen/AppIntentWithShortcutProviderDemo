//
//  MockDataGenerator.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/22.
//

import Foundation

// 定義假的資料生成器
class MockDataGenerator {
    
    static func generateMockItem() -> Item {
        let timestamp = Date()
        let id = UUID()
        let status: [ItemStatus] = [.on, .off, .on] // 模擬的狀態數據
        
        return Item(timestamp: timestamp, id: id, status: status)
    }
    
    static func generateMockItems(count: Int) -> [Item] {
        var items: [Item] = []
        let currentDate = Date()
        
        for i in 0..<count {
            let timestamp = currentDate.addingTimeInterval(TimeInterval(-i * 3600))
            let id = UUID()
            let status: [ItemStatus] = Bool.random() ? [.off] : [.on, .off, .on]// 模擬的狀態數據
            
            let item = Item(timestamp: timestamp, id: id, status: status)
            items.append(item)
        }
        
        return items
    }
}
