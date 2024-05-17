//
//  QuestionsReviewViewController+TableView.swift
//  Quizzy
//
//  Created by Nikolay Budai on 14/12/23.
//

import UIKit

extension QuestionsReviewViewController {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

extension QuestionsReviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.identifier,
                                                       for: indexPath) as? QuestionCell else {
            return UITableViewCell()
        }

        let cellViewModel = cellDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
}

extension QuestionsReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
