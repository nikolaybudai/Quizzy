//
//  QuestionCell.swift
//  Quizzy
//
//  Created by Nikolay Budai on 14/12/23.
//

import UIKit

final class QuestionCell: UITableViewCell {
    
    static let identifier = "QuestionCell"
    
    private let questionLabel = UILabel()
    private let isCorrectImageView = UIImageView()
    private let answerLabel = UILabel()
    private let answerStackView = UIStackView()
    
    private var imageName: String = ""
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
        setupQuestionLabel()
        setupAnswerLabel()
        setupIsCorrectImageView()
        setupAnswerStackView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15))
    }
    
    //MARK: Methods
    func setupCell(viewModel: QuestionCellViewModelProtocol) {
        self.selectionStyle = .none
        questionLabel.text = viewModel.question
        imageName = viewModel.isCorrect ? "tick" : "cross"
        isCorrectImageView.image = UIImage(named: imageName)
        answerLabel.text = viewModel.correctAnswer
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 15
        
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 3, height: 4)
        contentView.layer.shadowRadius = 2
    }
    
    //MARK: UI
    private func setupQuestionLabel() {
        questionLabel.textAlignment = .center
        questionLabel.textColor = .black
        questionLabel.font = UIFont(name: "Helvetica", size: 20)
        questionLabel.numberOfLines = 0
        addSubview(questionLabel)
    }
    
    private func setupAnswerLabel() {
        answerLabel.textAlignment = .left
        answerLabel.textColor = .black
        answerLabel.numberOfLines = 0
        answerLabel.font = UIFont(name: "Helvetica-bold", size: 16)
    }
    
    private func setupIsCorrectImageView() {
        isCorrectImageView.contentMode = .scaleAspectFit
    }
    
    private func setupAnswerStackView() {
        answerStackView.axis = .horizontal
        answerStackView.distribution = .fillProportionally
        answerStackView.addArrangedSubview(answerLabel)
        answerStackView.addArrangedSubview(isCorrectImageView)
        addSubview(answerStackView)
    }
    
}

extension QuestionCell {
    private func addConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        isCorrectImageView.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        answerStackView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        isCorrectImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.1)
        }
        
    }
}
