//
//  TemplatesResultPresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

protocol TemplatesResultPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func touchToPopVCBtn()
}

final class TemplatesResultPresenter {
    
    weak var view: TemplatesResultViewProtocol?
    
    let router: TemplatesResultRouterProtocol
    let interactor: TemplatesResultInteractorProtocol
    
    init(router: TemplatesResultRouterProtocol, interactor: TemplatesResultInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}


extension TemplatesResultPresenter: TemplatesResultPresenterProtocol {
    func touchToPopVCBtn() {
        router.popVC()
    }
    
    func viewDidLoaded() {
        view?.showInformation()
    }
    
    
}
