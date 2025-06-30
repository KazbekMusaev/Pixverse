//
//  SeeAllEffectsPresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

protocol SeeAllEffectsPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class SeeAllEffectsPresenter {
    
    weak var view: SeeAllEffectsViewProtocol?
    
    let router: SeeAllEffectsRouterProtocol
    let interactor: SeeAllEffectsInteractorProtocol
    
    init(router: SeeAllEffectsRouterProtocol, interactor: SeeAllEffectsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    
}

extension SeeAllEffectsPresenter: SeeAllEffectsPresenterProtocol {
    func viewDidLoaded() {
        view?.showInformation()
    }
}
