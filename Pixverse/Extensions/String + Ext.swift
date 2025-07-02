//
//  String + Ext.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

extension String {
    
    static let errorResponse = "error"
    static let successResponse = "success"
    
    
    func getFirstThreeWords() -> String {
        let words = self.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        guard !words.isEmpty else { return "" }
        
        let firstThreeWords = Array(words.prefix(3))
        return firstThreeWords.joined(separator: " ")
    }
}
