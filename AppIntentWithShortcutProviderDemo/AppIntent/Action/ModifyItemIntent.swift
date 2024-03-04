//
//  ModifyItemIntent.swift
//  AppIntentWithShortcutProviderDemo
//
//  Created by 陳邦亢 on 2024/2/23.
//

import Foundation
import AppIntents

struct ModifyItemIntent: AppIntent, PredictableIntent {
    static var title: LocalizedStringResource = "Modify an item"
    static var description = IntentDescription("Modify an item")

    static var parameterSummary: some ParameterSummary {
        Summary("Modify an item")
    }
    
    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction() {
            DisplayRepresentation(
                title: "Modify an Item",
                subtitle: ""
            )
        }
    }
    
    @Parameter(title: "Title", description: "Title of the item you want to modify", requestValueDialog: IntentDialog.itemTitleParameterPrompt)
    var item: ItemShortcutEntity
    
    @Parameter(title: "Operation", description: "Turn on or turn off the status", requestValueDialog: IntentDialog.itemStatusOperationParameterPrompt)
    var operation: ItemStatus
    
    @Parameter(title: "Status Index", 
               description: "The index of the status you want to modify",
               requestValueDialog: IntentDialog.itemStatusIndexParameterPrompt)
    var statusIndex: Int?
    
    init() {
    }
    
    init(_ operation: ItemStatus) {
        self.init()
        self.operation = operation
    }

    func perform() async throws -> some IntentResult & ProvidesDialog {
        
        if (self.item.status.count > 1 && (self.statusIndex == nil)) {
            self.statusIndex = try await self.$statusIndex.requestDisambiguation(among: Array(0..<self.item.status.count), dialog: IntentDialog.itemStatusIndexParameterPrompt)
        }
        else {
            self.item.status[self.statusIndex ?? 0] = self.operation
        }
        
        try await DataProvider.shared.updateItem(self.item)
        
        return .result(dialog: "Item modified succeed")
    }
}

fileprivate extension IntentDialog {
    static var itemTitleParameterPrompt: Self {
        "Which item do you want to modify？"
    }
    static var itemStatusIndexParameterPrompt: Self {
        "Which status do you want to modify？"
    }
    static var itemStatusOperationParameterPrompt: Self {
        "Do you want to turn it on or off?"
    }
    static var responseSuccess: Self {
        "Successfully modified."
    }
    static var responseFailure: Self {
        "Modification failed."
    }
}

