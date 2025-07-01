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
    
    func startCreateVideo(prompt: String)
    func getSuccessResponse()
    
    func videoGenerationCompleted(_ videoUrl: String, filePath: String, prompt: String)
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
    func videoGenerationCompleted(_ videoUrl: String, filePath: String, prompt: String) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.stopCreatingAnimations()
            self?.router.pushToResult(videoUrl, filePath: filePath, prompt: prompt)
        }
    }
    
    func getSuccessResponse() {
        interactor.loadVideoGenerateStatus()
    }
    
    func startCreateVideo(prompt: String) {
        interactor.createVideo(prompt: prompt)
        view?.showCreatingAnimations()
    }
    
    func touchToPopVCBtn() {
        router.popVC()
    }
    
    func viewDidLoaded() {
        view?.showInformation()
    }
}
