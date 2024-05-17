//
//  CoordinatorProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 24/10/23.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func showPreviousGames()
    func showCategoryChoiceScreen()
    func showQuestionsChoiceScreen(category: Category)
    func showQuestionsScreen(queryParameters: [URLQueryItem], categoryName: String)
    func showGameResultScreen(game: Game, questionsWithAnswers: [QuestionReview])
    func showQuestionsReviewScreen(questionsWithAnswers: [QuestionReview])
    func showRulesScreen()
    func goBack()
    func backToMenu()
}
