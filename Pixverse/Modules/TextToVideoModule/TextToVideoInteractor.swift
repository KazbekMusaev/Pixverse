//
//  TextToVideoInteractor.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

protocol TextToVideoInteractorProtocol {
    func createVideo(prompt: String)
    func loadVideoGenerateStatus()
}

final class TextToVideoInteractor: TextToVideoInteractorProtocol {
    
    weak var presenter: TextToVideoPresenterProtocol?
    
    private var statusDispatchTimer: DispatchSourceTimer?
    private var statusId: String?
    private let statusCheckInterval: TimeInterval = 5.0
    var saveVideoModel: SaveVideoModel?
    
    
    
    func createVideo(prompt: String) {
        saveVideoModel = SaveVideoModel(name: prompt, date: Date())
        
        NetworkManager.textToVideo(promptText: prompt) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.statusId = String(success.videoId)
                self.presenter?.getSuccessResponse()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    func loadVideoGenerateStatus() {
        statusDispatchTimer?.cancel()
        
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: statusCheckInterval)
        timer.setEventHandler { [weak self] in
            self?.checkVideoStatus()
        }
        timer.resume()
        
        statusDispatchTimer = timer
    }
    
    private func checkVideoStatus() {
        guard let statusId = self.statusId else {
            statusDispatchTimer?.cancel()
            return
        }
        
        NetworkManager.getVideoStatus(videoId: statusId) { [weak self] result in
            guard let self, let saveVideoModel else { return }
            switch result {
            case .success(let success):
                print("Статус видео: \(success.status)")
                if success.status == .successResponse {
                    self.statusDispatchTimer?.cancel()
                    var model = saveVideoModel
                    model.name = model.name.getFirstThreeWords()
                    self.startDownloadVideo(urlString: success.videoUrl ?? "", completion: { isDownload in
                        if isDownload {
                            self.presenter?.videoGenerationCompleted(success.videoUrl ?? "", filePath: model.getFileName(), prompt: saveVideoModel.name)
                            CoreManager.shared.createData(videoModel: model, pathToFiles: model.getFileName())
                        } else {
                            print("error download")
                        }
                    })
                    
                }
            case .failure(let failure):
                print("Ошибка проверки статуса: \(failure.localizedDescription)")
            }
        }
    }
    
    private func startDownloadVideo(urlString: String, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: urlString) else { return }
        NetworkManager.downloadVideo(url: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                if let saveVideoModel {
                    var model = saveVideoModel
                    model.name = model.name.getFirstThreeWords()
                    FileManagerService.saveVideoToFiles(videoModel: model, from: success) { isSave in
                        if isSave {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    
    
    
}
