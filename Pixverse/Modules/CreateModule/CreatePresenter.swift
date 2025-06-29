//
//  CreatePresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import Foundation

protocol CreatePresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class CreatePresenter {
    
    weak var view: CreateViewProtocol?
    
    let interactor: CreateInteractorProtocol
    let router: CreateRouterProtocol
    
    init(interactor: CreateInteractorProtocol, router: CreateRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension CreatePresenter: CreatePresenterProtocol {
    func viewDidLoaded() {
        print("CreatePresenter -> View did loaded")
        view?.showInformations()
    }
}
