//
//  QuestionsViewController.swift
//  Quizzy
//
//  Created by Nikolay Budai on 10/11/23.
//

import UIKit

final class QuestionsViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView()
    private let questionLabel = UILabel()
    private let answerButtonsStackView = UIStackView()
    private var scoreLabel = UILabel()
    private var answersButtons: [UIButton] = []
    
    private var currentQuestionNumber: Int = 0
    private var viewModel: QuestionsViewModelProtocol
    
    weak var coordinator: CoordinatorProtocol?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getQuestions()
    }

    //MARK: Init
    init(viewModel: QuestionsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    private func setupViews() {
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .systemBackground
        view.addSubview(activityIndicator)
        setupQuestionLabel()
        setupAnswerButtonsStackView()
        setupScoreLabel()
        addConstraints()
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { isLoading in
            guard let isLoading else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            }
        }
        
        viewModel.responseCode.bind { [weak self] responseCode in
            guard let self else { return }
            if responseCode == 1 {
                showAlert(title: "Not enought questions", message: "Sorry, we do not have enough questions with selected difficulty in this category. Try again!", coordinator: coordinator)
            } else if responseCode != 0 {
                showAlert(title: "Error", message: "Failed to load questions. Please, try again.", coordinator: coordinator)
            }
        }
        
        viewModel.currentQuestion.bind { [weak self] question in
            guard let self, let question else { return }
            reloadQuestionData(question: question)
        }
    }
    
    private func getQuestions() {
        viewModel.getQuestions { [weak self] error in
            guard let self else { return }
            if error != nil {
                print(error?.localizedDescription ?? "Couldn't load questions")
                showAlert(title: "Sorry!", message: "Couldn't load questions. Please try again!", coordinator: coordinator)
            }
        }
    }
    
    private func reloadQuestionData(question: Question?) {
        let questionText = question?.question.convertHtmlSpecialCharacters()
        questionLabel.text = questionText
        updateTitle()
        
        answersButtons.enumerated().forEach { index, button in
            let answers = viewModel.allAnswers
            let buttonTitle = answers[index].convertHtmlSpecialCharacters()
            button.setTitle(buttonTitle, for: .normal)
            button.backgroundColor = .customBackground
        }
        
        answersButtons.forEach { button in
            button.isUserInteractionEnabled = true
        }
    }
    
    @objc private func answerButtonTapped(_ sender: UIButton) {
        let selectedIndex = sender.tag
        
        disableButtons()
      
        viewModel.handleAnswerButtonTapped(selectedAnswersIndex: selectedIndex)
        
        viewModel.shouldExecuteCorrectIndexBinding = true
        bindCorrectAnswerIndex(selectedIndex: selectedIndex, sender: sender)
        bindScore()
        bindHasMoreQuestions()
    }
    
    private func disableButtons() {
        answersButtons.forEach { button in
            button.isUserInteractionEnabled = false
        }
    }
    
    private func updateTitle() {
        currentQuestionNumber += 1
        title = "\(currentQuestionNumber)/\(viewModel.numberOfQuestions)"
    }
    
    private func bindScore() {
        viewModel.score.bind { [weak self] score in
            guard let self, let score else { return }
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    private func bindCorrectAnswerIndex(selectedIndex: Int, sender: UIButton) {
        viewModel.correctAnswerIndex.bind { [weak self] correctAnswerIndex in
            guard let strongSelf = self else { return }
            guard strongSelf.viewModel.shouldExecuteCorrectIndexBinding else { return }
            UIView.animate(withDuration: 1) {
                guard let correctAnswerIndex else { return }
                if selectedIndex != correctAnswerIndex {
                    sender.backgroundColor = .systemRed
                }
                strongSelf.answersButtons[correctAnswerIndex].backgroundColor = .systemGreen
            }
        }
    }
    
    private func bindHasMoreQuestions() {
        viewModel.hasMoreQuestions.bind { [weak self] hasMoreQuestions in
            guard let strongSelf = self, let hasMoreQuestions else { return }
            if !hasMoreQuestions {
                strongSelf.disableButtons()
                let game = strongSelf.viewModel.createGame()
                strongSelf.coordinator?.showGameResultScreen(game: game, 
                                                             questionsWithAnswers: strongSelf.viewModel.questionsWithAnswers)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    strongSelf.viewModel.getNewQuestion()
                }
            }
        }
    }
    
    //MARK: UI
    private func setupQuestionLabel() {
        questionLabel.textColor = .black
        questionLabel.font = UIFont(name: "Helvetica", size: 20)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        view.addSubview(questionLabel)
    }
    
    private func setupAnswerButtonsStackView() {
        answerButtonsStackView.axis = .vertical
        answerButtonsStackView.spacing = 10
        answerButtonsStackView.alignment = .fill
        answerButtonsStackView.distribution = .fillEqually
        
        for i in 0..<4 {
            let button = UIButton()
            button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 7
            button.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
            button.tag = i
            answerButtonsStackView.addArrangedSubview(button)
            answersButtons.append(button)
        }
        
        view.addSubview(answerButtonsStackView)
    }
    
    private func setupScoreLabel() {
        scoreLabel.text = "Score: 0"
        scoreLabel.font = UIFont(name: "Helvetica", size: 26)
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .center
        view.addSubview(scoreLabel)
    }
    
}


extension QuestionsViewController {
    private func addConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        answerButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(120)
        }
        
        answerButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
}
