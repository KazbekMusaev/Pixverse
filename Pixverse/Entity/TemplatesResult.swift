//
//  TemplatesResult.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

struct TemplatesResult: Decodable {
    let appId: String
    let templates: [TemplatesModel]
    let styles: [StylesModel]
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case templates, styles, id
        case appId = "app_id"
    }
}
