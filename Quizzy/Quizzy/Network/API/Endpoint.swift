//
//  Endpoint.swift
//  Quizzy
//
//  Created by Nikolay Budai on 26/10/23.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "opentdb.com"
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid url components: \(components)")
        }
        
        return url
    }
}
