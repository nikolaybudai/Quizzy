//
//  QuestionsViewModel.swift
//  Quizzy
//
//  Created by Nikolay Budai on 10/11/23.
//

import Foundation

final class QuestionsViewModel: QuestionsViewModelProtocol {

    private let networkManager: NetworkManagerProtocol
    
    var isLoading: Observable<Bool> = Observable(false)
    var responseCode: Observable<Int> = Observable(0)
    var currentQuestion: Observable<Question?> = Observable(nil)
    var score: Observable<Int> = Observable(0)
    var correctAnswerIndex: Observable<Int> = Observable(0)
    var hasMoreQuestions: Observable<Bool> = Observable(true)
    
    var queryParameters: [URLQueryItem]
    var allAnswers: [String] = []
    var questionsWithAnswers: [QuestionReview] = []
    var numberOfQuestions: Int = 0
    var shouldExecuteCorrectIndexBinding: Bool = false
    
    private var categoryName: String
    private var questions: [Question] = []
    private var currentQuestionIndex = 0
    private var incorrectAnswers: [String] = []
    private var correctAnswer: String = ""
    private var correctAnswers: Int = 0
    private var isCorrect: Bool = false
    
    //MARK: Init
    init(networkManager: NetworkManagerProtocol, queryParameters: [URLQueryItem], categoryName: String) {
        self.networkManager = networkManager
        self.queryParameters = queryParameters
        self.categoryName = categoryName
    }
    
    //MARK: Methods
    func getQuestions(completion: @escaping (Error?) -> Void) {
        isLoading.value = true
        
        networkManager.fetchQuestions(queryItems: queryParameters) { [weak self] questionsResponse, error in
            guard let self else { return }
            isLoading.value = false
            if error != nil {
                completion(error)
            } else if let questionsResponse {
                questions = questionsResponse.results
                numberOfQuestions = questions.count
                getNewQuestion()
                responseCode.value = questionsResponse.responseCode
                completion(nil)
            }
        }
    }
    
    func handleAnswerButtonTapped(selectedAnswersIndex: Int) {
        if selectedAnswersIndex == correctAnswerIndex.value {
            correctAnswers += 1
            isCorrect = true
            
            switch questions[currentQuestionIndex].difficulty {
                case Difficulty.easy.rawValue:
                score.value? += Constants.pointsForEasyQuestion
                case Difficulty.medium.rawValue:
                    score.value? += Constants.pointsForMediumQuestion
                case Difficulty.hard.rawValue:
                    score.value? += Constants.pointsForHardQuestion
                default:
                    score.value? += 0
            }
        } else {
            isCorrect = false
        }
        
        let question = questions[currentQuestionIndex]
        let questionText = question.question.convertHtmlSpecialCharacters()
        let correctAnswer = question.correctAnswer.convertHtmlSpecialCharacters()
        let questionForReview = QuestionReview(question: questionText, correctAnswer: correctAnswer, isCorrect: isCorrect)
        questionsWithAnswers.append(questionForReview)
        
        currentQuestionIndex += 1
    }
    
    func getNewQuestion() {
        shouldExecuteCorrectIndexBinding = false
        if currentQuestionIndex < numberOfQuestions {
            let question = questions[currentQuestionIndex]
            incorrectAnswers = question.incorrectAnswers
            correctAnswer = question.correctAnswer
            allAnswers = shuffleAnswers(correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers)
            
            correctAnswerIndex.value = allAnswers.firstIndex(of: correctAnswer)
            currentQuestion.value = question
        } else {
            hasMoreQuestions.value = false
        }

    }
    
    func createGame() -> Game {
        let score = score.value ?? 0
        let numberOfQuestions = questions.count
        let game = Game(score: score,
                        numberOfQuestions: numberOfQuestions, 
                        correctAnswers: correctAnswers,
                        category: categoryName)
        return game
    }
    
    private func shuffleAnswers(correctAnswer: String, incorrectAnswers: [String]) -> [String] {
        var answers = [correctAnswer] + incorrectAnswers
        answers.shuffle()
        return answers
    }
    
}
