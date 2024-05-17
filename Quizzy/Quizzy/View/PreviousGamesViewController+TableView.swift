//
//  PreviousGamesViewController+TableView.swift
//  Quizzy
//
//  Created by Nikolay Budai on 22/12/23.
//

import UIKit

extension PreviousGamesViewController {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background") ?? UIImage())
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

//MARK: DataSource
extension PreviousGamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier,
                                                       for: indexPath) as? GameCell else {
            return UITableViewCell()
        }

        let cellViewModel = cellDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
}

//MARK: Delegate
extension PreviousGamesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
