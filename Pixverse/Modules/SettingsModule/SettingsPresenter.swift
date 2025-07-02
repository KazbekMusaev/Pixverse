//
//  SettingsPresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class SettingsPresenter {
    
    weak var view: SettingsViewProtocol?
    
    let router: SettingsRouterProtocol
    let interactor: SettingsInteractorProtocol
    
    init(router: SettingsRouterProtocol, interactor: SettingsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func viewDidLoaded() {
        print("SettingsPresenter -> view did loaded")
        view?.showInformations()
    }
}
