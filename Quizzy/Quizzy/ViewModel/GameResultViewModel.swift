//
//  GameResultViewModel.swift
//  Quizzy
//
//  Created by Nikolay Budai on 08/12/23.
//

import Foundation

final class GameResultViewModel: GameResultViewModelProtocol {
    
    private let dbManager: DBManagerProtocol
    private let game: Game
    
    var gameResults: Observable<Game>
    var questionsWithAnswers: [QuestionReview]
    
    //MARK: Init
    init(dbManager: DBManagerProtocol, game: Game, questionsWithAnswers: [QuestionReview]) {
        self.dbManager = dbManager
        self.game = game
        self.questionsWithAnswers = questionsWithAnswers
        gameResults = Observable(game)
    }
    
    //MARK: Methods
    func saveGame() {
        dbManager.save(game)
    }
    
}
