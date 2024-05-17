//
//  Question.swift
//  Quizzy
//
//  Created by Nikolay Budai on 29/10/23.
//

import Foundation

struct Question: Decodable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}
