//
//  ItemDetailView.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/22.
//

import SwiftUI

struct ItemDetailView: View {    
    var item: Item
    
    var body: some View {
        VStack {
            Text("Title: \(item.title)")
                .padding(.bottom, 20)
                .padding(.horizontal, 40)
            
            Text("Timestamp: \(formattedTimestamp)")
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            Text("Status Count: \(item.status.count)")
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            VStack {
                ForEach(item.status.indices, id: \.self) { index in
                    Toggle("Status \(index)", isOn: Binding(
                        get: { item.status[index] == .on },
                        set: { item.status[index] = $0 ? .on : .off }
                    ))
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
                }
            }
            
        }
        .padding()
    }
    
    private var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: item.timestamp)
    }
}

#Preview {
    let item = MockDataGenerator.generateMockItem()
    return ItemDetailView(item: item)
}


