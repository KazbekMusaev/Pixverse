//
//  EffectInteractor.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

protocol EffectInteractorProtocol {
    func loadData(templateId: String, image: Data)
    func loadVideoGenerateStatus()
}

final class EffectInteractor: EffectInteractorProtocol {
    
    
    weak var presenter: EffectPresenterProtocol?
    
    private var statusDispatchTimer: DispatchSourceTimer?
    private var statusId: String?
    private let statusCheckInterval: TimeInterval = 5.0
    var saveVideoModel: SaveVideoModel?
    
    func loadData(templateId: String, image: Data) {
        NetworkManager.createVideoWithTemplatesPhoto(templateId: templateId, image: image) { [weak self] result in
            switch result {
            case .success(let success):
                self?.statusId = String(success.videoId)
                self?.presenter?.getSuccessResponse()
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
                    
                    self.startDownloadVideo(urlString: success.videoUrl ?? "", completion: { isDownload in
                        if isDownload {
                            self.presenter?.videoGenerationCompleted(success.videoUrl ?? "", filePath: saveVideoModel.getFileName())
                            CoreManager.shared.createData(videoModel: saveVideoModel, pathToFiles: saveVideoModel.getFileName())
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
                    FileManagerService.saveVideoToFiles(videoModel: saveVideoModel, from: success) { isSave in
                        if isSave {
                            completion(true)
                        }
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
