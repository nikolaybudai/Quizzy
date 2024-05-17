//
//  GameCellViewModelProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 22/12/23.
//

import Foundation

protocol GameCellViewModelProtocol {
    var category: String { get set }
    var numberOfQuestions: Int { get set }
    var correctAnswers: Int { get set }
    var score: Int { get set }
}
