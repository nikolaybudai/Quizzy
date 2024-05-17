//
//  NetworkManager.swift
//  Quizzy
//
//  Created by Nikolay Budai on 31/10/23.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func fetchCategories(response: @escaping (GetAllCategoriesResponse?, NetworkError?) -> Void) {
        getCategotiesData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                do {
                    let categories = try jsonDecoder.decode(GetAllCategoriesResponse.self, from: data)
                    response(categories, nil)
                } catch let jsonError {
                    response(nil, .jsonError)
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(_):
                response(nil, .cannotParseData)
            }
        }
    }
    
    func fetchQuestions(queryItems: [URLQueryItem], response: @escaping (GetQuestionsResponse?, NetworkError?) -> Void) {
        getQuestionsData(queryItems: queryItems) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                do {
                    let questions = try jsonDecoder.decode(GetQuestionsResponse.self, from: data)
                    response(questions, nil)
                } catch let jsonError {
                    response(nil, .jsonError)
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(_):
                response(nil, .cannotParseData)
            }
        }
    }
    
    private func getCategotiesData(completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let endpoint = Endpoint(path: Path.categories.rawValue, queryItems: nil)
        URLSession.shared.request(endpoint: endpoint) { data, _, error in
            if error != nil {
                completion(.failure(.urlError))
            } else {
                guard let data else {
                    completion(.failure(.cannotParseData))
                    return
                }
                completion(.success(data))
            }
        }
    }
    
    private func getQuestionsData(queryItems: [URLQueryItem], completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let endpoint = Endpoint(path: Path.questions.rawValue, queryItems: queryItems)
        URLSession.shared.request(endpoint: endpoint) { data, _, error in
            if error != nil {
                completion(.failure(.urlError))
            } else {
                guard let data else {
                    completion(.failure(.cannotParseData))
                    return
                }
                completion(.success(data))
            }
        }
    }
    
}
