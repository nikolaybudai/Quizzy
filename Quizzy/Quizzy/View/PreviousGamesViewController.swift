//
//  PreviousGamesViewController.swift
//  Quizzy
//
//  Created by Nikolay Budai on 22/12/23.
//

import UIKit
import SnapKit

final class PreviousGamesViewController: UIViewController {
    
    let tableView = UITableView()
    
    weak var coordinator: CoordinatorProtocol?
    
    let viewModel: PreviousGamesViewModelProtocol
    var cellDataSource = [GameCellViewModelProtocol]()
    
    //MARK: Init
    init(viewModel: PreviousGamesViewModelProtocol) {
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
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        getGames()
    }
    
    //MARK: Methods
    private func setupViews() {
        title = "Your Games"
        
        view.addSubview(tableView)
        setupTableView()
        addConstraints()
    }
    
    private func getGames() {
        viewModel.getGames { [weak self] games in
            guard let self else { return }
            if !games {
                showAlert(title: "No games!", message: "There are no games yet. Start and play your first game!", coordinator: coordinator)
            }
        }
    }
    
    private func bindViewModel() {
        viewModel.cellDataSource.bind { [weak self] games in
            guard let self, let games else { return }
            cellDataSource = games
            reloadTableView()
        }
    }
}


extension PreviousGamesViewController {
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
