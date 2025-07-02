//
//  SaveVideoModel.swift
//  Pixverse
//
//  Created by KazbekMusaev on 01.07.2025.
//

import Foundation

struct SaveVideoModel {
    
    var name: String
    let date: Date
    
    func getFileName() -> String {
        name + " " + date.dateToString()
    }
    
}
