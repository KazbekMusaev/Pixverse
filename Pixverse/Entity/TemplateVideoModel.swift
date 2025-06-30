//
//  TemplateVideoModel.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

struct TemplateVideoModel: Decodable {
    let videoId: Int
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
        case videoId = "video_id"
    }
}
