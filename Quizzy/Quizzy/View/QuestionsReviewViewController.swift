//
//  QuestionsReviewViewController.swift
//  Quizzy
//
//  Created by Nikolay Budai on 14/12/23.
//

import UIKit
import SnapKit

final class QuestionsReviewViewController: UIViewController {

    let tableView = UITableView()
    
    weak var coordinator: CoordinatorProtocol?
    
    let viewModel: QuestionsReviewViewModelProtocol
    var cellDataSource = [QuestionCellViewModelProtocol]()
    
    //MARK: Init
    init(viewModel: QuestionsReviewViewModelProtocol) {
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
    
    //MARK: Methods
    private func setupViews() {
        title = "Questions Review"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        setupTableView()
        addConstraints()
    }
    
    private func bindViewModel() {
        viewModel.cellDataSource.bind { [weak self] questions in
            guard let self, let questions else { return }
            cellDataSource = questions
            reloadTableView()
        }
    }

}


extension QuestionsReviewViewController {
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
