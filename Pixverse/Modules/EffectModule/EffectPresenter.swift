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
    
    func imageIsSelect(templateId: String, image: Data)
    func getSuccessResponse()
    func getError(errorText: String)
    
    func videoGenerationCompleted(_ videoUrl: String, filePath: String)
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
    func videoGenerationCompleted(_ videoUrl: String, filePath: String) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.stopCreatingAnimations()
            self?.router.pushToResult(videoUrl, filePath: filePath)
        }
    }
    
    func getSuccessResponse() {
        interactor.loadVideoGenerateStatus()
    }
    
    func getError(errorText: String) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.getError(errorText)
        }
    }
    
    func imageIsSelect(templateId: String, image: Data) {
        DispatchQueue.main.async { [weak self] in 
            self?.view?.showCreatingAnimations()
        }
        interactor.loadData(templateId: templateId, image: image)
    }
    
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
