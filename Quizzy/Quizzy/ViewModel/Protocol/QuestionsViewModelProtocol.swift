//
//  QuestionsViewModelProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 10/11/23.
//

import Foundation

protocol QuestionsViewModelProtocol {
    var isLoading: Observable<Bool> { get set }
    var responseCode: Observable<Int> { get set }
    var currentQuestion: Observable<Question?> { get set }
    var score: Observable<Int> { get set }
    var correctAnswerIndex: Observable<Int> { get set }
    var hasMoreQuestions: Observable<Bool> { get set }
    
    var queryParameters: [URLQueryItem] { get set }
    var allAnswers: [String] { get set }
    var questionsWithAnswers: [QuestionReview] { get set }
    var numberOfQuestions: Int { get set }
    var shouldExecuteCorrectIndexBinding: Bool { get set }
    
    func getQuestions(completion: @escaping (Error?) -> Void)
    func getNewQuestion()
    func handleAnswerButtonTapped(selectedAnswersIndex: Int)
    func createGame() -> Game
}
