//
//  ImgAndTextToVideoRouter.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol ImgAndTextToVideoRouterProtocol: AnyObject {
    func popVC()
    func presentAddPhotoHelper()
    func pushToResult(_ videoUrl: String, filePath: String, prompt: String)
}

final class ImgAndTextToVideoRouter: ImgAndTextToVideoRouterProtocol {
    
    func popVC() {
        TabBarManager.shared.show()
        if let targetVC = view?.navigationController?.viewControllers.first(where: { $0 is CreateView }) {
            view?.navigationController?.popToViewController(targetVC, animated: true)
        }
    }
    
    
    weak var presenter: ImgAndTextToVideoPresenterProtocol?
    weak var view: ImgAndTextToVideoView?

    
    //MARK: - Module Builder
    static func build() -> UIViewController {
        let view = ImgAndTextToVideoView()
        let router = ImgAndTextToVideoRouter()
        let interactor = ImgAndTextToVideoInteractor()
        let presenter = ImgAndTextToVideoPresenter(router: router, interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        router.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
    func presentAddPhotoHelper() {
        let vc = AddPhotoHelperView()
        vc.imageAndTextDelegate = view
        
        vc.modalPresentationStyle = .formSheet
        vc.modalTransitionStyle = .flipHorizontal
        
        
        view?.present(vc, animated: true)
    }
    
    func pushToResult(_ videoUrl: String, filePath: String, prompt: String) {
        let vc = TemplatesResultRouter.buildWithPrompt(videoUrl, localFilePath: filePath, prompt: prompt)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
