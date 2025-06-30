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
    
    func videoGenerationCompleted(_ videoUrl: String)
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
    func videoGenerationCompleted(_ videoUrl: String) {
        DispatchQueue.main.async { [weak self] in
            self?.router.pushToResult(videoUrl)
            self?.view?.stopCreatingAnimations()
        }
    }
    
    func getSuccessResponse() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showCreatingAnimations()
        }
        interactor.loadVideoGenerateStatus()
    }
    
    func getError(errorText: String) {
        print(errorText)
    }
    
    func imageIsSelect(templateId: String, image: Data) {
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
