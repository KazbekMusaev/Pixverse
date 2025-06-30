//
//  VideoLoader.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import UIKit
import AVFoundation

final class VideoLoader {
    
    static let cache = NSCache<NSURL, UIImage>()
    private static var activeTasks = [UUID: DispatchWorkItem]()
    
    static func loadThumbnail(
        for videoURL: URL,
        completion: @escaping (UIImage?) -> Void
    ) -> UUID? {
        // Проверяем кэш
        if let cachedImage = cache.object(forKey: videoURL as NSURL) {
            completion(cachedImage)
            return nil
        }
        
        let taskID = UUID()
        
        // Создаем work item для отмены
        let workItem = DispatchWorkItem {
            let asset = AVAsset(url: videoURL)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            
            let time = CMTime(seconds: 0, preferredTimescale: 600)
            
            do {
                let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                
                cache.setObject(thumbnail, forKey: videoURL as NSURL)
                
                DispatchQueue.main.async {
                    completion(thumbnail)
                    activeTasks.removeValue(forKey: taskID)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                    activeTasks.removeValue(forKey: taskID)
                }
            }
        }
        
        // Сохраняем задачу
        activeTasks[taskID] = workItem
        
        // Запускаем в очереди с приоритетом
        DispatchQueue.global(qos: .userInitiated).async(execute: workItem)
        
        return taskID
    }
    
    static func cancelTask(_ id: UUID) {
        DispatchQueue.main.async {
            activeTasks[id]?.cancel()
            activeTasks.removeValue(forKey: id)
        }
    }
    
    private static func downloadVideo(from url: URL, completion: @escaping (URL?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { tempURL, _, error in
            guard let tempURL = tempURL, error == nil else {
                completion(nil)
                return
            }
            
            // Перемещаем файл в кэш, чтобы он не удалился автоматически
            let fileManager = FileManager.default
            let cacheDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let destinationURL = cacheDir.appendingPathComponent(url.lastPathComponent)
            
            do {
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                try fileManager.moveItem(at: tempURL, to: destinationURL)
                completion(destinationURL)
            } catch {
                print("Ошибка сохранения видео: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    private static func generateThumbnail(from videoURL: URL, completion: @escaping (UIImage?) -> Void ) {
        // Указываем QoS .userInitiated для важных задач
        DispatchQueue.global(qos: .userInitiated).async {
            let asset = AVAsset(url: videoURL)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            
            let time = CMTime(seconds: 0, preferredTimescale: 600)
            
            do {
                let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                completion(thumbnail)
            } catch {
                print("Ошибка генерации превью: \(error)")
                completion(nil)
            }
        }
    }
}
