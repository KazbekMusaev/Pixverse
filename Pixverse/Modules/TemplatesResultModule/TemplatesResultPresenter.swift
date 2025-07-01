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
    
    func shareBtnTaped()
    func tryToShare(_ filePath: String)
    
    func deleteBtnTaped()
    func succesDelete()
    func errorDelete()
    
    func saveBtnTaped()
    func succesSave()
    func errorSave()
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
    func succesSave() {
        view?.showSuccesSaveAllert()
    }
    
    func errorSave() {
        view?.showErrorSaveAlert()
    }
    
    func saveBtnTaped() {
        interactor.saveVideoInLibrary()
    }
    
    func succesDelete() {
        router.popVC()
    }
    
    func errorDelete() {
        print("error delete")
    }
    
    func deleteBtnTaped() {
        interactor.deleteFile()
    }
    
    func tryToShare(_ filePath: String) {
        router.shareAction(urlString: filePath)
    }
    
    func shareBtnTaped() {
        interactor.getFilePath()
    }
    
    func touchToPopVCBtn() {
        router.popVC()
    }
    
    func viewDidLoaded() {
        view?.showInformation()
    }
    
    
}
