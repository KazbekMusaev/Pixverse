//
//  StylesModel.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

struct StylesModel: Decodable {
    let prompt: String
    let name: String
    let isActive: Bool
    let previewSmall: String
    let previewLarge: String
    let id: Int
    let templateId: Int
    
    enum CodingKeys: String, CodingKey {
        case prompt, name, id
        case isActive = "is_active"
        case previewSmall = "preview_small"
        case previewLarge = "preview_large"
        case templateId = "template_id"
    }
}
