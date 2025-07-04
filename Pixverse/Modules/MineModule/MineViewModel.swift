//
//  MineViewModel.swift
//  Pixverse
//
//  Created by KazbekMusaev on 04.07.2025.
//

import Foundation

final class MineViewModel: ObservableObject {
    
    @Published var allVideos: [VideoModel] = CoreManager.shared.posts
    weak var presenter: MinePresenterProtocol?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notification: )), name: NSNotification.Name("reload"), object: nil)
    }
    
    @objc func reloadData(notification: NSNotification) {
        allVideos = CoreManager.shared.posts
    }
    
    deinit {
        print("destroi MineViewModel")
    }
}
