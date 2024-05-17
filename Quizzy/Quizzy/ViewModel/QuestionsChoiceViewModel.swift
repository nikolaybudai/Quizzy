//
//  QuestionsViewModel.swift
//  Quizzy
//
//  Created by Nikolay Budai on 03/11/23.
//

import Foundation

final class QuestionsChoiceViewModel: QuestionsChoiceViewModelProtocol {
    
    var category: Category
    
    //MARK: Init
    init(category: Category) {
        self.category = category
    }
    
    //MARK: Methods
    func difficultyOptions() -> [String] {
        Difficulty.allCases.map { option in
            option.rawValue
        }
    }
    
    func makeQueryParameters(amount: Int, category: Category, difficlty: String? = nil) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "amount", value: String(amount)))
        queryItems.append(URLQueryItem(name: "category", value: String(category.id)))
        if let difficlty {
            queryItems.append(URLQueryItem(name: "difficulty", value: difficlty))
        }
        queryItems.append(URLQueryItem(name: "type", value: QuestionType.multiple.rawValue))
        return queryItems
    }
    
}
