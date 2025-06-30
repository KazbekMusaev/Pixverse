//
//  VideoStatusModel.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

struct VideoStatusModel: Decodable {
    let status: String
    let videoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case videoUrl = "video_url"
    }
}
