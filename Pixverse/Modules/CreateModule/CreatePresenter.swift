//
//  CreatePresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import Foundation

protocol CreatePresenterProtocol: AnyObject {
    func viewDidLoaded()
    func goToTextToVideo()
    func goToImgAndTextToVideo()
    func goToSeeAll(_ category: [TemplatesModel])
    func getTemplates(_ model: [TemplatesModel])
    
    func startLoadData()
    func showTemplates(_ model: [TemplatesModel])
    func showError(_ errorText: String)
    
    func selectItemInCollection(model: TemplatesModel)
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
    func selectItemInCollection(model: TemplatesModel) {
        router.pushToEffect(model: model)
    }
    
    func startLoadData() {
        interactor.loadTemplates()
    }
    
    func showError(_ errorText: String) {
        print(errorText)
    }
    
    func showTemplates(_ model: [TemplatesModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.finishLoadData(model)
        }
    }
    
    func getTemplates(_ model: [TemplatesModel]) {
        router.pushToSeeAll(model)
    }
    
    func goToSeeAll(_ category: [TemplatesModel]) {
        router.pushToSeeAll(category)
    }
    
    func goToImgAndTextToVideo() {
        router.pushToImgAndTextToVideo()
    }
    
    func goToTextToVideo() {
        router.pushToTextToVideo()
    }
    
    func viewDidLoaded() {
        print("CreatePresenter -> View did loaded")
        view?.showInformations()
    }
}
