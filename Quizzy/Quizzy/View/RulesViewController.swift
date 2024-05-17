//
//  RulesViewController.swift
//  Quizzy
//
//  Created by Nikolay Budai on 24/12/23.
//

import UIKit
import SnapKit

final class RulesViewController: UIViewController {
    
    private let backgroundImageView = UIImageView()
    
    private let firstStepLabel = UILabel()
    private let secondStepLabel = UILabel()
    private let thirdStepLabel = UILabel()
    private let stepsLabelsStackView = UIStackView()
    
    private let pointsViewsStackView = UIStackView()
    
    private var difficulties: [String] = {
        var values = [String]()
        Difficulty.allCases.forEach { difficulty in
            values.append(difficulty.rawValue)
        }
        return values
    }()
    
    private var points: [Int] = {
        return [Constants.pointsForEasyQuestion,
                Constants.pointsForMediumQuestion,
                Constants.pointsForHardQuestion]
    }()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addConstraints()
    }
    
    //MARK: Methods
    private func setupViews() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background") ?? UIImage())
        title = "Rules"
        
        setupBackgroundImageView()
        setupFirstStepLabel()
        setupSecondStepLabel()
        setupThirdStepLabel()
        setupStepsLabelsStackView()
        setupPointsViewsStackView()
    }
    
    //MARK: UI
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    private func setupFirstStepLabel() {
        firstStepLabel.text = "1. Choose the category"
        firstStepLabel.font = UIFont(name: "Helvetica-bold", size: 24)
        firstStepLabel.textColor = .black
        firstStepLabel.numberOfLines = 0
        view.addSubview(firstStepLabel)
    }

    private func setupSecondStepLabel() {
        secondStepLabel.text = "2. Choose the difficulty and the number of questions"
        secondStepLabel.font = UIFont(name: "Helvetica-bold", size: 24)
        secondStepLabel.textColor = .black
        secondStepLabel.numberOfLines = 0
        view.addSubview(secondStepLabel)
    }
    
    private func setupThirdStepLabel() {
        thirdStepLabel.text = "3. Answer and score points!"
        thirdStepLabel.font = UIFont(name: "Helvetica-bold", size: 24)
        thirdStepLabel.textColor = .black
        thirdStepLabel.numberOfLines = 0
        view.addSubview(thirdStepLabel)
    }
    
    private func setupStepsLabelsStackView() {
        stepsLabelsStackView.addArrangedSubview(firstStepLabel)
        stepsLabelsStackView.addArrangedSubview(secondStepLabel)
        stepsLabelsStackView.addArrangedSubview(thirdStepLabel)
        stepsLabelsStackView.distribution = .fillEqually
        stepsLabelsStackView.axis = .vertical
        view.addSubview(stepsLabelsStackView)
    }
    
    private func setupPointsViewsStackView() {
        pointsViewsStackView.axis = .vertical
        pointsViewsStackView.spacing = 10
        pointsViewsStackView.distribution = .fillEqually
        view.addSubview(pointsViewsStackView)

        for i in 0...2 {
            let view = createPointsView(difficulties[i], points[i])
            pointsViewsStackView.addArrangedSubview(view)
        }
    }
    
    private func createPointsView(_ difficulty: String, _ points: Int) -> UIView {
        let pointsView = UIView()
        pointsView.backgroundColor = .systemGray6
        pointsView.layer.cornerRadius = 8

        let label1 = UILabel()
        label1.font = UIFont(name: "Helvetica-bold", size: 24)
        label1.text = difficulty
        label1.textColor = .customBackground

        let label2 = UILabel()
        label2.font = UIFont(name: "Helvetica-bold", size: 24)
        label2.textAlignment = .right
        label2.text = "+ \(points) points"
        label2.textColor = .customBackground

        let labelsStackView = UIStackView(arrangedSubviews: [label1, label2])
        labelsStackView.axis = .horizontal
        labelsStackView.spacing = 5

        pointsView.addSubview(labelsStackView)

        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(40)
        }

        return pointsView
    }
    
}


extension RulesViewController {
    private func addConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        stepsLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        stepsLabelsStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        pointsViewsStackView.snp.makeConstraints { make in
            make.top.equalTo(stepsLabelsStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
    }
}
