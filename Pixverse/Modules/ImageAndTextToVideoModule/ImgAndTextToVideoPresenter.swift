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
    func createBtnTaped(prompt: String, image: Data)
    
    func addPhotoTaped()
    func getSuccessResponse()
    
    func videoGenerationCompleted(_ videoUrl: String, filePath: String, prompt: String)
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
    func videoGenerationCompleted(_ videoUrl: String, filePath: String, prompt: String) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.stopCreatingAnimations()
            self?.router.pushToResult(videoUrl, filePath: filePath, prompt: prompt)
        }
    }
    
    func getSuccessResponse() {
        interactor.loadVideoGenerateStatus()
    }
    
    
    func addPhotoTaped() {
        router.presentAddPhotoHelper()
    }
    
    func createBtnTaped(prompt: String, image: Data) {
        interactor.createVideo(prompt: prompt, image: image)
        view?.showCreatingAnimations()
    }
    
    func viewDidLoaded() {
        view?.showInformation()
    }
    
    func touchToPopVCBtn() {
        router.popVC()
    }
}
