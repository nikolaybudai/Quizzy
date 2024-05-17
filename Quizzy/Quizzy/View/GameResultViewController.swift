//
//  GameResultViewController.swift
//  Quizzy
//
//  Created by Nikolay Budai on 08/12/23.
//

import UIKit
import SnapKit

final class GameResultViewController: UIViewController {
    
    private let backgroundImageView = UIImageView()
    private let categoryLabel = UILabel()
    private let scoreLabel = UILabel()
    private let questionsNumberLabel = UILabel()
    private let labelsStackView = UIStackView()
    private let backgroundView = UIView()
    private let seeAnswersButton = UIButton()
    private let finishButton = UIButton()

    private let viewModel: GameResultViewModelProtocol
    
    weak var coordinator: CoordinatorProtocol?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addConstraints()
        bindViewModel()
    }
    
    //MARK: Init
    init(viewModel: GameResultViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    private func setupViews() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background") ?? UIImage())
        navigationItem.setHidesBackButton(true, animated: true)
        title = "Result"
        
        setupBackgroundImageView()
        setupBackgroundView()
        setupCategoryLabel()
        setupScoreLabel()
        setupQuestionsNumberLabel()
        setupSeeAnswersButton()
        setupLabelsStackView()
        setupFinishButton()
    }
    
    private func bindViewModel() {
        viewModel.gameResults.bind { [weak self] gameResults in
            guard let self else { return }
            if let gameResults {
                categoryLabel.text = gameResults.category
                scoreLabel.text = "Your score: \(gameResults.score)"
                questionsNumberLabel.text = "\(gameResults.correctAnswers)/\(gameResults.numberOfQuestions)"
            }
        }
    }
    
    @objc private func didTapFinishButton() {
        viewModel.saveGame()
        coordinator?.backToMenu()
    }
    
    @objc private func didTapSeeAnswersButton() {
        coordinator?.showQuestionsReviewScreen(questionsWithAnswers: viewModel.questionsWithAnswers)
    }
    
    //MARK: UI
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = .systemGray6
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.shadowColor = UIColor.darkGray.cgColor
        backgroundView.layer.shadowOpacity = 0.4
        backgroundView.layer.shadowOffset = CGSize(width: 4, height: 6)
        backgroundView.layer.shadowRadius = 2
        view.addSubview(backgroundView)
    }
    
    private func setupCategoryLabel() {
        categoryLabel.font = UIFont(name: "Helvetica-bold", size: 26)
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .center
        categoryLabel.textColor = .black
    }
    
    private func setupScoreLabel() {
        scoreLabel.font = UIFont(name: "Helvetica-bold", size: 30)
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = .black
    }
    
    private func setupQuestionsNumberLabel() {
        questionsNumberLabel.font = UIFont(name: "Helvetica-bold", size: 26)
        questionsNumberLabel.textAlignment = .center
        questionsNumberLabel.textColor = .black
    }
    
    private func setupSeeAnswersButton() {
        seeAnswersButton.setTitle("See Answers", for: .normal)
        seeAnswersButton.backgroundColor = .customBackground
        seeAnswersButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        seeAnswersButton.layer.cornerRadius = 5
        seeAnswersButton.addTarget(self, action: #selector(didTapSeeAnswersButton), for: .touchUpInside)
        backgroundView.addSubview(seeAnswersButton)
    }
    
    private func setupLabelsStackView() {
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .fill
        labelsStackView.distribution = .fillEqually
        labelsStackView.spacing = 10
        labelsStackView.addArrangedSubview(categoryLabel)
        labelsStackView.addArrangedSubview(scoreLabel)
        labelsStackView.addArrangedSubview(questionsNumberLabel)
        backgroundView.addSubview(labelsStackView)
    }
    
    private func setupFinishButton() {
        finishButton.setTitle("Finish", for: .normal)
        finishButton.layer.cornerRadius = 7
        finishButton.titleLabel?.font = UIFont(name: "Helvetica", size: 24)
        finishButton.backgroundColor = .customBackground
        finishButton.addTarget(self, action: #selector(didTapFinishButton), for: .touchUpInside)
        view.addSubview(finishButton)
    }
    
}


extension GameResultViewController {
    private func addConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        seeAnswersButton.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-80)
        }
        
        finishButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(55)
        }
        
        seeAnswersButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
    }
}
