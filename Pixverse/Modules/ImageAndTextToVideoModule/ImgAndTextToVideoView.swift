//
//  ImgAndTextToVideoView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol ImgAndTextToVideoViewProtocol: AnyObject {
    func showInformation()
    func showCreatingAnimations()
}

final class ImgAndTextToVideoView: UIViewController {

    var presenter: ImgAndTextToVideoPresenterProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    deinit {
        presenter?.touchToPopVCBtn()
    }

    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(navBar)
        view.addSubview(createBtn)
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            createBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: - View elements
    private lazy var creatingLoadView = CreatingVideoAnimateView()
    private lazy var navBar = ComponentBuilder.getCustomEmptyNavigationBar(title: "Create", action: popVCAction)
    
    private lazy var createBtn: UIButton = {
        let btn = ComponentBuilder.getCustomBtn(action: createAction, text: "Save", textColor: .labelQuintuple)
        btn.isEnabled = false
        btn.backgroundColor = .accentGrey
//        DispatchQueue.main.async {
//            btn.addHorizontalGradient(colors: [.accentPrimary, .accentSecondary])
//        }
        return btn
    }()
    
    //MARK: - Actions
    private lazy var popVCAction = UIAction { [weak self] _ in
        guard let self else { return }
        presenter?.touchToPopVCBtn()
    }

    private lazy var createAction = UIAction { [weak self] _ in
        guard let self else { return }
        self.createBtn.clickAnimate()
        self.presenter?.createBtnTaped()
    }
}

extension ImgAndTextToVideoView: ImgAndTextToVideoViewProtocol {
    
    func showInformation() {
        settupView()
    }
    
    func showCreatingAnimations() {
        
        creatingLoadView.action = { [weak self] in
            self?.presenter?.touchToPopVCBtn()
        }
        
        creatingLoadView.settupView()
        
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self else { return }
            self.view.addSubview(self.creatingLoadView)
            
            NSLayoutConstraint.activate([
                self.creatingLoadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.creatingLoadView.topAnchor.constraint(equalTo: view.topAnchor),
                self.creatingLoadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.creatingLoadView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
    }
}
