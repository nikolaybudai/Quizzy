//
//  QuestionCellViewModel.swift
//  Quizzy
//
//  Created by Nikolay Budai on 18/12/23.
//

import Foundation

final class QuestionCellViewModel: QuestionCellViewModelProtocol {
    
    var question: String
    var correctAnswer: String
    var isCorrect: Bool
    
    //MARK: Init
    init(_ questionReview: QuestionReview) {
        self.question = questionReview.question
        self.correctAnswer = questionReview.correctAnswer
        self.isCorrect = questionReview.isCorrect
    }
    
}
