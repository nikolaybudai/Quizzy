//
//  NetworkManagerProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 31/10/23.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func fetchCategories(response: @escaping (GetAllCategoriesResponse?, NetworkError?) -> Void)
    
    func fetchQuestions(queryItems: [URLQueryItem], response: @escaping (GetQuestionsResponse?, NetworkError?) -> Void)
    
}
