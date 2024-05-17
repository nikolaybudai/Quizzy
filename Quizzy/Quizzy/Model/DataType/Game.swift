//
//  Game.swift
//  Quizzy
//
//  Created by Nikolay Budai on 06/12/23.
//

import Foundation
import RealmSwift

class Game: Object {
    @Persisted var score: Int = 0
    @Persisted var numberOfQuestions: Int = 0
    @Persisted var correctAnswers: Int = 0
    @Persisted var category: String = ""
    @Persisted var date: Date = Date()
    
    convenience init(score: Int, numberOfQuestions: Int, correctAnswers: Int, category: String) {
        self.init()
        self.score = score
        self.numberOfQuestions = numberOfQuestions
        self.correctAnswers = correctAnswers
        self.category = category
    }
}
