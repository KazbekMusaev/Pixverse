//
//  MinePresenter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import Foundation

protocol MinePresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func dataIsLoaded(model: [VideoModel])
    func showEmptyView()
    
    func touchCreateBtn()
    
    func itemIsSelect(model: VideoModel)
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
    func itemIsSelect(model: VideoModel) {
        guard let pathToFiles = model.pathToFiles else { return }
        router.goToResultModule(fileName: pathToFiles)
    }
    
    func touchCreateBtn() {
        router.changeTab()
    }
    
    func showEmptyView() {
        view?.dataIsEmpty()
    }
    
    func dataIsLoaded(model: [VideoModel]) {
        view?.reloadData(model)
    }
    
    func viewDidLoaded() {
        view?.showInformations()
        interactor.startLoadData()
    }
}
