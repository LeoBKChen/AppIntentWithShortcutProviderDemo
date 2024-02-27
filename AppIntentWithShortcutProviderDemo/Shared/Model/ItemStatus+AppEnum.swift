//
//  ItemStatus+AppEnum.swift
//  
//
//  Created by 陳邦亢 on 2024/2/6.
//

import Foundation
import AppIntents
import SwiftData

enum ItemStatus: String, CaseIterable, Codable {
    case on = "turn on"
    case off = "turn off"
}

extension ItemStatus {
    mutating func toggle() {
        self = self == .on ? .off : .on
    }
}

extension ItemStatus: AppEnum {
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "switch status")
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .on: "turn on",
        .off: "turn off"
    ]
}

extension ItemStatus {
    func boolValue() -> Bool {
        switch self {
        case .off:
            return false
        case .on:
            return true
        }
    }
}
