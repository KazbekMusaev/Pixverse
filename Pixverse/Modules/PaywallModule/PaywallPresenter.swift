//
//  PaywallPresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 03.07.2025.
//

import Foundation

protocol PaywallPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func tapToPopVc()
}

final class PaywallPresenter {
    
    weak var view: PaywallViewProtocol?
    
    let router: PaywallRouterProtocol
    let interactor: PaywallInteractorProtocol
    
    init(router: PaywallRouterProtocol, interactor: PaywallInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension PaywallPresenter: PaywallPresenterProtocol {
    func tapToPopVc() {
        router.popVC()
    }
    
    func viewDidLoaded() {
        view?.showInformation()
    }
    
    
}
