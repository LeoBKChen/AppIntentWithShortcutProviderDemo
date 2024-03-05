//
//  AddItemIntent.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/23.
//

import Foundation
import AppIntents

struct AddItemIntent: AppIntent, PredictableIntent {
    static var title: LocalizedStringResource = "Add Item"
    static var description = IntentDescription("Add an item")
    
    static var parameterSummary: some ParameterSummary {
        Summary("Add an item")
    }
    
    @Parameter(title: "Title", description: "Title of the new item", requestValueDialog: IntentDialog.itemTitleParameterPrompt)
    var title: String
    
    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction() { 
            DisplayRepresentation(
                title: "Add an Item",
                subtitle: ""
            )
        }
    }
    
    init() {
        _ = DataProvider.shared
    }
    
    func perform() async throws -> some ProvidesDialog {
        let item = Item(timestamp: Date(), id: UUID(), title: self.title, status: [.off, .off, .off])
        
        await DataProvider.shared.insertItem(item)
        
        return .result(dialog: "Item added succeed")
    }
}

fileprivate extension IntentDialog {
    static var itemTitleParameterPrompt: Self {
        "Input the title:"
    }
}
