//
//  EffectPresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

protocol EffectPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func touchToPopVCBtn()
    func touchToContinueBtn()
}

final class EffectPresenter {
    
    weak var view: EffectViewProtocol?
    
    let router: EffectRouterProtocol
    let interactor: EffectInteractorProtocol
    
    init(router: EffectRouterProtocol, interactor: EffectInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension EffectPresenter: EffectPresenterProtocol {
    func touchToContinueBtn() {
        router.presentAddPhotoHelper()
    }
    
    func touchToPopVCBtn() {
        router.popVC()
    }
    
    func viewDidLoaded() {
        view?.showInforamtion()
    }
}
