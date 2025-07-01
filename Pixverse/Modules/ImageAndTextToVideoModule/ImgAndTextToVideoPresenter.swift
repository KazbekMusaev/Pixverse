//
//  ImgAndTextToVideoPresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

protocol ImgAndTextToVideoPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func touchToPopVCBtn()
    func createBtnTaped()
}

final class ImgAndTextToVideoPresenter {
    
    weak var view: ImgAndTextToVideoViewProtocol?
    
    let router: ImgAndTextToVideoRouterProtocol
    let interactor: ImgAndTextToVideoInteractorProtocol
    
    init(router: ImgAndTextToVideoRouterProtocol, interactor: ImgAndTextToVideoInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension ImgAndTextToVideoPresenter: ImgAndTextToVideoPresenterProtocol {
    func createBtnTaped() {
        view?.showCreatingAnimations()
    }
    
    func viewDidLoaded() {
        view?.showInformation()
    }
    
    func touchToPopVCBtn() {
        router.popVC()
    }
}
