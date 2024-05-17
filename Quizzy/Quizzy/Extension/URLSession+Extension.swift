//
//  URLSession+Extension.swift
//  Quizzy
//
//  Created by Nikolay Budai on 31/10/23.
//

import Foundation

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func request(endpoint: Endpoint, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint.url, completionHandler: handler)
        task.resume()
        return task
    }
}
