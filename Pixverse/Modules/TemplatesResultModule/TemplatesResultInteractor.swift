//
//  TemplatesResultInteractor.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

protocol TemplatesResultInteractorProtocol {
    func getFilePath()
    func deleteFile()
    func saveVideoInLibrary()
}

final class TemplatesResultInteractor: TemplatesResultInteractorProtocol {
    func saveVideoInLibrary() {
        guard let fileName else { return }
        if let path = FileManagerService.getFileURL(fileName: fileName + ".mp4") {
            FileManagerService.saveVideoToPhotoLibrary(fileURL: path) { [weak self] isSave in
                guard let self else { return }
                if isSave {
                    self.presenter?.succesSave()
                } else {
                    self.presenter?.errorSave()
                }
            }
        } else {
            presenter?.errorSave()
        }
    }
    
    func deleteFile() {
        guard let fileName else { return }
        if let saveVideoIndex = CoreManager.shared.posts.firstIndex(where: { $0.pathToFiles == fileName }) {
            CoreManager.shared.posts[saveVideoIndex].deleteData()
        }
        if let path = FileManagerService.getFileURL(fileName: fileName + ".mp4") {
            FileManagerService.deleteFile(url: path) { [weak self] isDelete in
                if isDelete {
                    self?.presenter?.succesDelete()
                } else {
                    self?.presenter?.errorDelete()
                }
            }
        } else {
            presenter?.errorDelete()
        }
    }
    
    
    func getFilePath() {
        guard let fileName else { return }
        presenter?.tryToShare(fileName)
    }
    
    
    weak var presenter: TemplatesResultPresenterProtocol?
    var fileName: String?
    
}
