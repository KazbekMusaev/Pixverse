//
//  TemplatesResultRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol TemplatesResultRouterProtocol: AnyObject {
    func popVC()
    func shareAction(urlString: String)
}

final class TemplatesResultRouter: TemplatesResultRouterProtocol {
    
    weak var view: TemplatesResultView?
    weak var presenter: TemplatesResultPresenterProtocol?
    
    //MARK: - Module Builder
    static func build(_ videoUrl: String, localFilePath: String) -> UIViewController {
        let view = TemplatesResultView()
        let interactor = TemplatesResultInteractor()
        let router = TemplatesResultRouter()
        let presenter = TemplatesResultPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        view.videoURL = videoUrl
        
        presenter.view = view
        
        interactor.presenter = presenter
        interactor.fileName = localFilePath
        
        router.presenter = presenter
        router.view = view
        
        return view
    }
    
    static func buildWithPrompt(_ videoUrl: String, localFilePath: String, prompt: String) -> UIViewController {
        let view = TemplatesResultView()
        let interactor = TemplatesResultInteractor()
        let router = TemplatesResultRouter()
        let presenter = TemplatesResultPresenter(router: router, interactor: interactor)
        
        view.prompt = prompt
        view.presenter = presenter
        view.videoURL = videoUrl
        
        presenter.view = view
        
        interactor.presenter = presenter
        interactor.fileName = localFilePath
        
        router.presenter = presenter
        router.view = view
        
        return view
    }
    
    func popVC() {
        TabBarManager.shared.show()
        if let targetVC = view?.navigationController?.viewControllers.first(where: { $0 is CreateView }) {
            view?.navigationController?.popToViewController(targetVC, animated: true)
        }
    }
    
    func shareAction(urlString: String) {
        if let fileURL = FileManagerService.getFileURL(fileName: urlString + ".mp4"), let view {
            ComponentBuilder.presentShareSheet(for: fileURL, from: view)
        } else {
            print("Файл не найден")
        }
    }
}
