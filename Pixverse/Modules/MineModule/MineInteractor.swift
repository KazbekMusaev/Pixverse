//
//  MineInteractor.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import Foundation

protocol MineInteractorProtocol {
    func startLoadData()
}

final class MineInteractor: MineInteractorProtocol {
    
    weak var presenter: MinePresenterProtocol?
    
    
    func startLoadData() {
        if CoreManager.shared.posts.isEmpty {
            presenter?.showEmptyView()
        } else {
            presenter?.dataIsLoaded(model: CoreManager.shared.posts)
        }
    }
    
}
