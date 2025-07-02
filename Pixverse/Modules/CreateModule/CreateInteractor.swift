//
//  CreateInteractor.swift
//  Pixverse
//
//  Created by KazbekMusaev on 29.06.2025.
//

import Foundation

protocol CreateInteractorProtocol {
    func getTemplatesByCategory(_ category: String)
    func loadTemplates()
}

final class CreateInteractor: CreateInteractorProtocol {
    func loadTemplates() {
        NetworkManager.getTemplates { [weak self] result in
            switch result {
            case .success(let templates):
                self?.presenter?.showTemplates(templates.templates)
            case .failure(let error):
                self?.presenter?.showError(error.localizedDescription)
            }
        }
    }
    
    func getTemplatesByCategory(_ category: String) {
//        var templates: [TemplatesModel] = []
//        
    }
    
    weak var presenter: CreatePresenterProtocol?
    
}
