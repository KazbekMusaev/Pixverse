//
//  CashInformation.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

final class CashInformation {
    
    static let shared = CashInformation()
    
    private init() {}
    
    var allTemplates: [TemplatesModel] = []
    
}
