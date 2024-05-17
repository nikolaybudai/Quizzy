//
//  QuestionViewController.swift
//  Quizzy
//
//  Created by Nikolay Budai on 03/11/23.
//

import UIKit

final class QuestionsChoiceViewController: UIViewController {
    
    private let categoryNameLabel = UILabel()
    private let difficultyStackView = UIStackView()
    private let chooseDifficultyLabel = UILabel()
    private let numberOfQuestionsLabel = UILabel()
    private let numberOfQuestionsLabelsStackView = UIStackView()
    private let numberOfQuestionsSlider = UISlider()
    private let startButton = UIButton()
    
    private var selectedDifficultyButton: UIButton?
    
    private let viewModel: QuestionsChoiceViewModelProtocol
    
    weak var coordinator: CoordinatorProtocol?
    
    private var selectedDifficulty: String?
    private var numberOfQuestions: Int = Constants.minimumNumberOfQuestions
    
    private var difficultyOptions: [String] {
        viewModel.difficultyOptions()
    }
    
    //MARK: Init
    init(viewModel: QuestionsChoiceViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addConstraints()
    }
    
    //MARK: Methods
    @objc private func didTapDiffuciltyButton(_ sender: UIButton) {
        guard let difficulty = sender.currentTitle else { return }
        selectedDifficulty = difficulty
        sender.backgroundColor = .black
        
        selectedDifficultyButton?.backgroundColor = .darkGray
        selectedDifficultyButton = sender
    }
    
    @objc private func selectNumberOfQuestions(_ sender: UISlider) {
        let step: Float = 5
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        numberOfQuestions = Int(numberOfQuestionsSlider.value)
        numberOfQuestionsLabel.text = String(Int(numberOfQuestionsSlider.value))
    }
    
    @objc private func didTapStartButton() {
        if selectedDifficulty == "all" {
            selectedDifficulty = nil
        }
        let parameters = viewModel.makeQueryParameters(amount: numberOfQuestions, category: viewModel.category, difficlty: selectedDifficulty)
        coordinator?.showQuestionsScreen(queryParameters: parameters, categoryName: viewModel.category.name)
    }

    
    //MARK: UI
    private func setupViews() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background") ?? UIImage())
        
        setupCategoryNameLabel()
        setupDifficultyStackView()
        setupChooseDifficultyLabel()
        setupNumberOfQuestionsLabelsStackView()
        setupNumberOfQuestionsSlider()
        setupStartButton()
    }
    
    private func setupCategoryNameLabel() {
        categoryNameLabel.text = viewModel.category.name
        categoryNameLabel.font = UIFont(name: "Helvetica-bold", size: 28)
        categoryNameLabel.textColor = .black
        categoryNameLabel.textAlignment = .center
        categoryNameLabel.numberOfLines = 0
        view.addSubview(categoryNameLabel)
    }
    
    private func setupDifficultyStackView() {
        difficultyStackView.axis = .vertical
        difficultyStackView.alignment = .fill
        difficultyStackView.distribution = .fillEqually
        difficultyStackView.spacing = 10
        
        difficultyOptions.forEach { option in
            let button = UIButton()
           
            button.titleLabel?.font = UIFont(name: "Helvetica", size: 24)
            button.layer.cornerRadius = 5
            button.setTitle(option, for: .normal)
            if option == "all" {
                button.backgroundColor = .black
                selectedDifficultyButton = button
            } else {
                button.backgroundColor = .darkGray
            }
            button.addTarget(self, action: #selector(didTapDiffuciltyButton), for: .touchUpInside)
            difficultyStackView.addArrangedSubview(button)
        }
        
        view.addSubview(difficultyStackView)
    }
    
    private func setupChooseDifficultyLabel() {
        chooseDifficultyLabel.text = "Difficulty:"
        chooseDifficultyLabel.font = UIFont(name: "Helvetica", size: 26)
        chooseDifficultyLabel.textColor = .black
        chooseDifficultyLabel.textAlignment = .center
        view.addSubview(chooseDifficultyLabel)
    }
    
    private func setupNumberOfQuestionsLabelsStackView() {
        let textLabel = UILabel()
        textLabel.text = "Number of questions: "
        textLabel.font = UIFont(name: "Helvetica", size: 24)
        textLabel.textColor = .black
        numberOfQuestionsLabelsStackView.addArrangedSubview(textLabel)
        
        numberOfQuestionsLabel.text = "\(Constants.minimumNumberOfQuestions)"
        numberOfQuestionsLabel.font = UIFont(name: "Helvetica-bold", size: 24)
        numberOfQuestionsLabel.textColor = .black
        numberOfQuestionsLabelsStackView.addArrangedSubview(numberOfQuestionsLabel)
        
        numberOfQuestionsLabelsStackView.axis = .horizontal
        numberOfQuestionsLabelsStackView.spacing = 10
        numberOfQuestionsLabelsStackView.distribution = .fillProportionally
        
        view.addSubview(numberOfQuestionsLabelsStackView)
    }
    
    private func setupNumberOfQuestionsSlider() {
        numberOfQuestionsSlider.minimumValue = Float(Constants.minimumNumberOfQuestions)
        numberOfQuestionsSlider.maximumValue = Float(Constants.maximumNumberOfQuestions)
        numberOfQuestionsSlider.minimumTrackTintColor = .black
        numberOfQuestionsSlider.thumbTintColor = .black
        numberOfQuestionsSlider.maximumTrackTintColor = .lightGray
        numberOfQuestionsSlider.addTarget(self, action: #selector(selectNumberOfQuestions), for: .valueChanged)
        view.addSubview(numberOfQuestionsSlider)
    }
    
    private func setupStartButton() {
        startButton.backgroundColor = .customBackground
        startButton.titleLabel?.font = UIFont(name: "Helvetica-bold", size: 24)
        startButton.layer.cornerRadius = 10
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        view.addSubview(startButton)
    }
    
}

//MARK: - Constraints
extension QuestionsChoiceViewController {
    private func addConstraints() {
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        chooseDifficultyLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryNameLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
        
        difficultyStackView.snp.makeConstraints { make in
            make.top.equalTo(chooseDifficultyLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        numberOfQuestionsLabelsStackView.snp.makeConstraints { make in
            make.top.equalTo(difficultyStackView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        numberOfQuestionsSlider.snp.makeConstraints { make in
            make.top.equalTo(numberOfQuestionsLabelsStackView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(55)
        }
    }
}
