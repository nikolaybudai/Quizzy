//
//  MainMenuViewController.swift
//  Quizzy
//
//  Created by Nikolay Budai on 03/11/23.
//

import UIKit
import SnapKit

class MainMenuViewController: UIViewController {
    
    private let backgroundImageView = UIImageView()
    private let startGameButton = UIButton()
    private let previousGamesButton = UIButton()
    private let rulesButton = UIButton()
    
    weak var coordinator: CoordinatorProtocol?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addConstraints()
    }
    
    //MARK: Methods
    private func setupViews() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background") ?? UIImage())
        title = "Menu"
        
        setupNavigationController()
        setupBackgroundImageView()
        setupStartGameButton()
        setupPreviousGamesButton()
        setupRulesButton()
    }
    
    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .customBackground
        appearance.titleTextAttributes = [.font: UIFont(name: "Helvetica-bold", size: 22) ?? .systemFont(ofSize: 22),
                                          .foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    private func setupStartGameButton() {
        startGameButton.setTitle("Start Game", for: .normal)
        startGameButton.backgroundColor = .customBackground
        startGameButton.titleLabel?.font = UIFont(name: "Helvetica-bold", size: 24)
        startGameButton.layer.cornerRadius = 10
        startGameButton.addTarget(self, action: #selector(didTapStartGameButton), for: .touchUpInside)
        view.addSubview(startGameButton)
    }
    
    private func setupPreviousGamesButton() {
        previousGamesButton.setAttributedTitle("Previous Games".underLined, for: .normal)
        previousGamesButton.backgroundColor = .clear
        previousGamesButton.setTitleColor(.black, for: .normal)
        previousGamesButton.titleLabel?.font = UIFont(name: "Helvetica-bold", size: 26)
        previousGamesButton.addTarget(self, action: #selector(didTapPreviousGamesButton), for: .touchUpInside)
        view.addSubview(previousGamesButton)
    }
    
    private func setupRulesButton() {
        rulesButton.setAttributedTitle("Rules".underLined, for: .normal)
        rulesButton.backgroundColor = .clear
        rulesButton.titleLabel?.textColor = .darkGray
        rulesButton.titleLabel?.font = UIFont(name: "Helvetica", size: 22)
        rulesButton.addTarget(self, action: #selector(didTapRulesButton), for: .touchUpInside)
        view.addSubview(rulesButton)
    }
    
    @objc private func didTapStartGameButton() {
        coordinator?.showCategoryChoiceScreen()
    }
    
    @objc private func didTapPreviousGamesButton() {
        coordinator?.showPreviousGames()
    }
    
    @objc private func didTapRulesButton() {
        coordinator?.showRulesScreen()
    }

}

extension MainMenuViewController {
    private func addConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        previousGamesButton.translatesAutoresizingMaskIntoConstraints = false
        rulesButton.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        startGameButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(60)
        }
        
        previousGamesButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(30)
            make.top.equalTo(startGameButton.snp.bottom).offset(40)
        }
        
        rulesButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80)
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(30)
        }
    }
}
