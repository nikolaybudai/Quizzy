//
//  GameResultViewModelProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 08/12/23.
//

import Foundation

protocol GameResultViewModelProtocol {
    var gameResults: Observable<Game> { get set }
    var questionsWithAnswers: [QuestionReview] { get set }
    
    func saveGame()
}
