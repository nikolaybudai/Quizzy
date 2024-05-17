//
//  QuestionCellViewModelProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 14/12/23.
//

import Foundation

protocol QuestionCellViewModelProtocol {
    var question: String { get set }
    var correctAnswer: String { get set }
    var isCorrect: Bool { get set }
}
