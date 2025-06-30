//
//  TextToVideoView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol TextToVideoViewProtocol: AnyObject {
    func showInformation()
}

final class TextToVideoView: UIViewController {

    var presenter: TextToVideoPresenterProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settupView()
    }
    
    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(navBar)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
        ])
    }
    
    //MARK: - View elements
    private lazy var navBar = ComponentBuilder.getCustomEmptyNavigationBar(title: "Create", action: popVCAction)
    
    //MARK: - Actions
    private lazy var popVCAction = UIAction { [weak self] _ in
        guard let self else { return }
        presenter?.touchToPopVCBtn()
    }
    

}

extension TextToVideoView: TextToVideoViewProtocol {
    func showInformation() {
        settupView()
    }
}
