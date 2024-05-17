//
//  ViewController.swift
//  Quizzy
//
//  Created by Nikolay Budai on 23/10/23.
//

import UIKit
import SnapKit

final class CategoryChoiceViewController: UIViewController {
    
    let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    
    weak var coordinator: CoordinatorProtocol?
    
    let viewModel: CategoryChoiceViewModelProtocol
    var cellDataSource = [CategoryCellViewModelProtocol]()
    
    //MARK: Init
    init(viewModel: CategoryChoiceViewModelProtocol) {
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
        super.viewDidAppear(animated)
        
        getCategories()
    }
    
    //MARK: Methods
    private func setupViews() {
        title = "Category"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        setupTableView()
        addConstraints()
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { isLoading in
            guard let isLoading else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] categories in
            guard let self, let categories else { return }
            cellDataSource = categories
            reloadTableView()
        }
    }
    
    private func getCategories() {
        viewModel.getCategories() { [weak self] error in
            if error != nil {
                guard let self else { return }
                showAlert(title: "Sorry!", message: "Couldn't load categories. Please, try again.", coordinator: coordinator)
            }
        }
    }

}

//MARK: - Constraints

extension CategoryChoiceViewController {
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
