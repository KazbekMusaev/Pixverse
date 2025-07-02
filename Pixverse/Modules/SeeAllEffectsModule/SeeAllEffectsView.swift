//
//  SeeAllEffectsView.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit

protocol SeeAllEffectsViewProtocol: AnyObject {
    func showInformation()
}

final class SeeAllEffectsView: UIViewController {

    var presenter: SeeAllEffectsPresenterProtocol?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - Functions
    private func settupView() {
        view.backgroundColor = .background
    }
    
    //MARK: - View elements
    
    
    //MARK: - Actions

}

extension SeeAllEffectsView: SeeAllEffectsViewProtocol {
    func showInformation() {
        settupView()
    }
}
