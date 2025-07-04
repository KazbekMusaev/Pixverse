//
//  MineHostingView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 04.07.2025.
//

import SwiftUI
import UIKit

final class MineHostingView: UIViewController {
    
    weak var presenter: MinePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = MineViewModel()
        viewModel.presenter = presenter
        let swiftUIView = MineSwiftUIView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.backgroundColor = .background
        view.backgroundColor = .background
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Сообщаем, что дочерний контроллер добавлен
        hostingController.didMove(toParent: self)
    }

}
