//
//  TextToVideoPresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

protocol TextToVideoPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func touchToPopVCBtn()
}

final class TextToVideoPresenter {
    
    weak var view: TextToVideoView?
    
    let router: TextToVideoRouterProtocol
    let interactor: TextToVideoInteractorProtocol
    
    init(router: TextToVideoRouterProtocol, interactor: TextToVideoInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension TextToVideoPresenter: TextToVideoPresenterProtocol {
    func touchToPopVCBtn() {
        router.popVC()
    }
    
    func viewDidLoaded() {
        view?.showInformation()
    }
}
