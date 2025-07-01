//
//  FileManagerService.swift
//  Pixverse
//
//  Created by KazbekMusaev on 01.07.2025.
//

import Foundation
import Photos

final class FileManagerService {
    
    private init() {}
    
    static func saveVideoToFiles(videoModel: SaveVideoModel, from location: URL, completion: @escaping (Bool) -> ()) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectory.appendingPathComponent(videoModel.getFileName() + ".mp4")

        do {
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }

            try fileManager.copyItem(at: location, to: destinationURL)
            completion(true)
            print("Видео сохранено в: \(destinationURL)")
        } catch {
            print("Ошибка при сохранении видео: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    static func getFileURL(fileName: String) -> URL? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentsDirectory?.appendingPathComponent(fileName)
    }
    
    static func deleteFile(url: URL, completion: @escaping (Bool) -> ()) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: url)
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    static func saveVideoToPhotoLibrary(fileURL: URL, completion: @escaping (Bool) -> ()) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized || status == .limited else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }

            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL)
            }) { success, error in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        }
    }
    
}
