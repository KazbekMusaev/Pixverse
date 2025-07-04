//
//  SettingsView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 28.06.2025.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func showInformations()
}

final class SettingsView: UIViewController {

    var presenter: SettingsPresenterProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
        
        view.addSubview(settingView.view)
        view.addSubview(navBar)
    
        
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            settingView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingView.view.topAnchor.constraint(lessThanOrEqualTo: navBar.bottomAnchor),
        ])
    }
    
    //MARK: - View elements
    private lazy var navBar = ComponentBuilder.getCustomNavigationBar(title: "Settings")
    
    private lazy var settingView: UIViewController = {
        let vc = SettingHostingView()
        vc.presenter = presenter
        return vc
    }()
    
    //MARK: - Actions

}

extension SettingsView: SettingsViewProtocol {
    func showInformations() {
        settupView()
    }
}


