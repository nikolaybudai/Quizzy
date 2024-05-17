//
//  GameCellViewModel.swift
//  Quizzy
//
//  Created by Nikolay Budai on 22/12/23.
//

import Foundation

final class GameCellViewModel: GameCellViewModelProtocol {
    
    var category: String
    var numberOfQuestions: Int
    var correctAnswers: Int
    var score: Int
    
    //MARK: Init
    init(_ game: Game) {
        self.category = game.category
        self.numberOfQuestions = game.numberOfQuestions
        self.correctAnswers = game.correctAnswers
        self.score = game.score
    }
}
