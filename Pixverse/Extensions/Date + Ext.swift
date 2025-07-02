//
//  Date + Ext.swift
//  Pixverse
//
//  Created by KazbekMusaev on 01.07.2025.
//

import Foundation

extension Date {
    func dateToString(format: String = "yyyy-MM-dd") -> String {
        let formater = DateFormatter()
        formater.dateFormat = format
        let yearAndMounthPlusDay = formater.string(from: self)
        return yearAndMounthPlusDay
    }
}
