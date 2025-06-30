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
        print("start")
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
    
//    static func getData(completion: @escaping (Result<ToDoModel, Error>) -> ()) {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "dummyjson.com"
//        urlComponents.path = "/todos"
//        guard let url = urlComponents.url else { return }
//        let req = URLRequest(url: url)
//        
//        URLSession.shared.dataTask(with: req) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else { return }
//            
//            do {
//                let response = try JSONDecoder().decode(ToDoModel.self, from: data)
//                completion(.success(response))
//            } catch {
//                completion(.failure(error))
//            }
//            
//        }.resume()
//
//    }
    
}
