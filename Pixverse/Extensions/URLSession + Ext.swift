//
//  URLSession + Ext.swift
//  Pixverse
//
//  Created by KazbekMusaev on 30.06.2025.
//

import Foundation

extension URLSession {
    static func getUrlComponents(_ path: String) -> URLComponents? {
        let serverId = "api-use-core.store"
        let scheme = "https"
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = serverId
        urlComponents.path = path
        return urlComponents
    }
}
