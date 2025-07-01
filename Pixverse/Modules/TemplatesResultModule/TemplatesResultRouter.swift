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
    weak var delegate: EffectRouterProtocol?
    
    //MARK: - Module Builder
    static func build(_ videoUrl: String, delegate: EffectRouterProtocol, localFilePath: String) -> UIViewController {
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
        router.delegate = delegate
        
        
        return view
    }
    
    func popVC() {
        delegate?.popVC()
    }
    
    func shareAction(urlString: String) {
        if let fileURL = FileManagerService.getFileURL(fileName: urlString + ".mp4"), let view {
            ComponentBuilder.presentShareSheet(for: fileURL, from: view)
        } else {
            print("Файл не найден")
        }
    }
}
