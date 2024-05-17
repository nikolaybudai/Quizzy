//
//  GameCell.swift
//  Quizzy
//
//  Created by Nikolay Budai on 22/12/23.
//

import UIKit
import SnapKit

final class GameCell: UITableViewCell {
    
    static let identifier = "GameCell"
    
    private let categoryLabel = UILabel()
    private let numberOfQuestionsLabel = UILabel()
    private let scoreLabel = UILabel()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
        setupCategoryLabel()
        setupNumberOfQuestionsLabel()
        setupScoreLabel()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 5, right: 15))
    }
    
    //MARK: Methods
    func setupCell(viewModel: GameCellViewModelProtocol) {
        self.selectionStyle = .none
        backgroundColor = .clear
        categoryLabel.text = viewModel.category
        numberOfQuestionsLabel.text = "\(viewModel.correctAnswers)/\(viewModel.numberOfQuestions)"
        scoreLabel.text = "Score: \(viewModel.score)"
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 15
        
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowOffset = CGSize(width: 5, height: 7)
        contentView.layer.shadowRadius = 4
    }
    
    //MARK: UI
    private func setupCategoryLabel() {
        categoryLabel.font = UIFont(name: "Helvetica-bold", size: 22)
        categoryLabel.textColor = .black
        categoryLabel.textAlignment = .center
        categoryLabel.numberOfLines = 0
        addSubview(categoryLabel)
    }
    
    private func setupNumberOfQuestionsLabel() {
        numberOfQuestionsLabel.font = UIFont(name: "Helvetica", size: 22)
        numberOfQuestionsLabel.textColor = .black
        numberOfQuestionsLabel.textAlignment = .center
        addSubview(numberOfQuestionsLabel)
    }
    
    private func setupScoreLabel() {
        scoreLabel.font = UIFont(name: "Helvetica-bold", size: 24)
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .center
        addSubview(scoreLabel)
    }
    
}


extension GameCell {
    private func addConstraints() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfQuestionsLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        numberOfQuestionsLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
    }
}
