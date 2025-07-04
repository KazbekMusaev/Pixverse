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
    
    static func loadThumbnail(for videoURL: URL, completion: @escaping (UIImage?) -> Void) -> UUID? {
        if let cachedImage = cache.object(forKey: videoURL as NSURL) {
            completion(cachedImage)
            return nil
        }
        
        let taskID = UUID()
        
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
        
        activeTasks[taskID] = workItem
        
        DispatchQueue.global(qos: .userInitiated).async(execute: workItem)
        
        return taskID
    }
    
    static func cancelTask(_ id: UUID) {
        DispatchQueue.main.async {
            activeTasks[id]?.cancel()
            activeTasks.removeValue(forKey: id)
        }
    }
    
    private static func generateThumbnail(from videoURL: URL, completion: @escaping (UIImage?) -> Void ) {
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
    
    static func addVideoPlayer(to view: UIView, filename: String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let videoURL = documentsDirectory.appendingPathComponent(filename)
        
        guard FileManager.default.fileExists(atPath: videoURL.path) else {
            print("Video file not found")
            return
        }
        
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(playerLayer)
    }
    
    
    static func generateThumbnailSUI(from filename: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let videoURL = documentsDirectory.appendingPathComponent(filename + ".mp4")
        
        guard FileManager.default.fileExists(atPath: videoURL.path) else {
            print("Video file not found")
            return nil
        }
        
        let asset = AVAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print("Thumbnail generation error: \(error)")
            return nil
        }
    }
}
