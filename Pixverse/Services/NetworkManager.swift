//
//  NetworkManager.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

final class NetworkManager {
    
    private init () {}
    
    ///Метод для получения Templates
    static func getTemplates(complition: @escaping (Result<TemplatesResult, Error>) -> ()) {
        guard let urlComponents = URLSession.getUrlComponents("/pixverse/api/v1/get_templates/com.test.test") else { return }
        guard let url = urlComponents.url else { return }
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let error = error {
                complition(.failure(error))
                print("error -> \(error.localizedDescription)")
                return
            }
            guard let data else {
                let error = NSError(domain: "Data is nill", code: 400)
                complition(.failure(error))
                print("error -> \(error.localizedDescription)")
                return
            }
            
            do {
                let items = try JSONDecoder().decode(TemplatesResult.self, from: data)
                complition(.success(items))
            } catch {
                complition(.failure(error))
                print("error -> \(error.localizedDescription)")
            }
            
        }.resume()
        
    }
    
    ///Метод для создания видео из Templates
    static func createVideoWithTemplatesPhoto(templateId: String, image: Data, completion: @escaping (Result<TemplateVideoModel, Error>) -> ()) {
        
        guard var urlComponents = URLSession.getUrlComponents("/pixverse/api/v1/template2video") else { return }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "userId", value: "test"),
            URLQueryItem(name: "appId", value: "com.test.test"),
            URLQueryItem(name: "templateId", value: templateId)
        ]
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        guard let url = urlComponents.url else { return }
        var req = URLRequest(url: url)
        
        var body = Data()
        let filename = "image.jpg"
        let mimeType = "image/jpg"
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimeType)\r\n\r\n")
        body.append(image)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")
        
        req.httpMethod = "POST"
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        req.httpBody = body

        let task = URLSession.shared.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data else {
                let error = NSError(domain: "Data is nill", code: 400)
                completion(.failure(error))
                print("error -> \(error.localizedDescription)")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TemplateVideoModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    ///Метод для получения статуса окончания генерации видео по id
    static func getVideoStatus(videoId: String, completion: @escaping (Result<VideoStatusModel, Error>) -> ()) {
        
        guard var urlComponents = URLSession.getUrlComponents("/pixverse/api/v1/status") else { return }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: videoId),
        ]
        
        guard let url = urlComponents.url else { return }
        var req = URLRequest(url: url)
        
        req.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data else {
                let error = NSError(domain: "Data is nill", code: 400)
                completion(.failure(error))
                print("error -> \(error.localizedDescription)")
                return
            }
            do {
                let result = try JSONDecoder().decode(VideoStatusModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    ///Метод для скачивания видео
    static func downloadVideo(url: URL, completion: @escaping (Result<URL, Error>) -> ()) {
        let task = URLSession.shared.downloadTask(with: url) { localURL, response, error in
            if let localURL {
                completion(.success(localURL))
            } else if let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
