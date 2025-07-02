//
//  TextToVideoRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol TextToVideoRouterProtocol: AnyObject {
    func popVC()
    func pushToResult(_ videoUrl: String, filePath: String, prompt: String)
}

final class TextToVideoRouter: TextToVideoRouterProtocol {
    func pushToResult(_ videoUrl: String, filePath: String, prompt: String) {
        let vc = TemplatesResultRouter.buildWithPrompt(videoUrl, localFilePath: filePath, prompt: prompt)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVC() {
        TabBarManager.shared.show()
        if let targetVC = view?.navigationController?.viewControllers.first(where: { $0 is CreateView }) {
            view?.navigationController?.popToViewController(targetVC, animated: true)
        }
    }
    
    
    weak var view: TextToVideoView?
    weak var presenter: TextToVideoPresenterProtocol?
    
    
    //MARK: - Module Builder
    static func build() -> UIViewController {
        let view = TextToVideoView()
        let interactor = TextToVideoInteractor()
        let router = TextToVideoRouter()
        let presenter = TextToVideoPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        
        return view
    }
}
