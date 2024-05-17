//
//  GameCoordinator.swift
//  Quizzy
//
//  Created by Nikolay Budai on 24/10/23.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainMenuViewController = MainMenuViewController()
        mainMenuViewController.coordinator = self
        navigationController.pushViewController(mainMenuViewController, animated: true)
    }
    
    func showPreviousGames() {
        let dbManager = DBManager()
        let viewModel = PreviousGamesViewModel(dbManager: dbManager)
        let previousGamesViewController = PreviousGamesViewController(viewModel: viewModel)
        previousGamesViewController.coordinator = self
        navigationController.pushViewController(previousGamesViewController, animated: true)
    }
    
    func showCategoryChoiceScreen() {
        let networkManager = NetworkManager()
        let viewModel = CategoryChoiceViewModel(networkManager: networkManager)
        let categoryChoiceViewController = CategoryChoiceViewController(viewModel: viewModel)
        categoryChoiceViewController.coordinator = self
        navigationController.pushViewController(categoryChoiceViewController, animated: true)
    }
    
    func showQuestionsChoiceScreen(category: Category) {
        let viewModel = QuestionsChoiceViewModel(category: category)
        let questionsChoiceViewController = QuestionsChoiceViewController(viewModel: viewModel)
        questionsChoiceViewController.coordinator = self
        navigationController.pushViewController(questionsChoiceViewController, animated: true)
    }
    
    func showQuestionsScreen(queryParameters: [URLQueryItem], categoryName: String) {
        let networkManager = NetworkManager()
        let viewModel = QuestionsViewModel(networkManager: networkManager, queryParameters: queryParameters, categoryName: categoryName)
        let questionsViewController = QuestionsViewController(viewModel: viewModel)
        questionsViewController.coordinator = self
        navigationController.pushViewController(questionsViewController, animated: true)
    }
    
    func showGameResultScreen(game: Game, questionsWithAnswers: [QuestionReview]) {
        let dbManager = DBManager()
        let viewModel = GameResultViewModel(dbManager: dbManager, game: game, questionsWithAnswers: questionsWithAnswers)
        let gameResultViewController = GameResultViewController(viewModel: viewModel)
        gameResultViewController.coordinator = self
        navigationController.pushViewController(gameResultViewController, animated: true)
    }
    
    func showQuestionsReviewScreen(questionsWithAnswers: [QuestionReview]) {
        let viewModel = QuestionsReviewViewModel(questionsWithAnswers: questionsWithAnswers)
        let questionsReviewViewController = QuestionsReviewViewController(viewModel: viewModel)
        questionsReviewViewController.coordinator = self
        navigationController.pushViewController(questionsReviewViewController, animated: true)
    }
    
    func showRulesScreen() {
        let rulesViewController = RulesViewController()
        navigationController.pushViewController(rulesViewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func backToMenu() {
        navigationController.popToRootViewController(animated: true)
    }
    
}
