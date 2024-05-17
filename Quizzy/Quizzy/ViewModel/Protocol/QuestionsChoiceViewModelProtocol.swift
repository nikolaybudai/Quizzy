//
//  QuestionsViewModelProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 03/11/23.
//

import Foundation

protocol QuestionsChoiceViewModelProtocol {
    var category: Category { get set }
    func difficultyOptions() -> [String]
    func makeQueryParameters(amount: Int, category: Category, difficlty: String?) -> [URLQueryItem]
}
