//
//  HostingVC.swift
//  Pixverse
//
//  Created by KazbekMusaev on 02.07.2025.
//

import UIKit
import SwiftUI

final class SettingHostingView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swiftUIView = SettingSwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.backgroundColor = .background
        view.backgroundColor = .background
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Сообщаем, что дочерний контроллер добавлен
        hostingController.didMove(toParent: self)
    }

}
