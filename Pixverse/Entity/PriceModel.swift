//
//  PriceModel.swift
//  Pixverse
//
//  Created by KazbekMusaev on 04.07.2025.
//

import Foundation

struct PriceModel {
    let period: Period
    let price: Int
    let onSale: Bool
    let discountPersent: Int
}


enum Period: String {
    case year, week
}
