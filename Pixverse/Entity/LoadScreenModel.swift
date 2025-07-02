//
//  LoadScreenModel.swift
//  Pixverse
//
//  Created by KazbekMusaev on 02.07.2025.
//

import Foundation

struct LoadScreenModel {
    let img: String
    let header: String
    static func getData() -> [LoadScreenModel] {
        [
            LoadScreenModel(img: "loadSreen1", header: "Inflate object in your photo"),
            LoadScreenModel(img: "loadSreen2", header: "Crumble any object"),
            LoadScreenModel(img: "loadSreen3", header: "Large variety of effects"),
        ]
    }
}
