//
//  SaveVideoModel.swift
//  Pixverse
//
//  Created by KazbekMusaev on 01.07.2025.
//

import Foundation

struct SaveVideoModel {
    
    let name: String
    let date: Date
    
    func getFileName() -> String {
        name + " " + date.dateToString()
    }
    
}
