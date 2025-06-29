//
//  MinePresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import Foundation

protocol MinePresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class MinePresenter {
    
    weak var view: MineViewProtocol?
    
    let router: MineRouterProtocol
    let interactor: MineInteractorProtocol
    
    init(router: MineRouterProtocol, interactor: MineInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension MinePresenter: MinePresenterProtocol {
    func viewDidLoaded() {
        print("MinePresenter -> view did loaded")
        view?.showInformations()
    }
}
