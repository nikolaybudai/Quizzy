//
//  CategoryChoiceViewController+TableView.swift
//  Quizzy
//
//  Created by Nikolay Budai on 31/10/23.
//

import UIKit

extension CategoryChoiceViewController {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

//MARK: Delegate
extension CategoryChoiceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = viewModel.dataSource else { return }
        let category = dataSource.triviaCategories[indexPath.row]
        coordinator?.showQuestionsChoiceScreen(category: category)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

//MARK: DataSource
extension CategoryChoiceViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, 
                                                       for: indexPath) as? CategoryCell else {
            return UITableViewCell()
        }

        let cellViewModel = cellDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
}
