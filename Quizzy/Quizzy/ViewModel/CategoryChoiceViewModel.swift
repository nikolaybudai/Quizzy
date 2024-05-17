//
//  GameViewModel.swift
//  Quizzy
//
//  Created by Nikolay Budai on 24/10/23.
//

import Foundation

final class CategoryChoiceViewModel: CategoryChoiceViewModelProtocol {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[CategoryCellViewModelProtocol]> = Observable([])
    var dataSource: GetAllCategoriesResponse?
    
    private let networkManager: NetworkManagerProtocol
    
    //MARK: Init
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    //MARK: Methods
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.triviaCategories.count ?? 0
    }
    
    func getCategories(_ completion: @escaping (Error?) -> Void) {
        isLoading.value = true
        
        networkManager.fetchCategories { [weak self] categories, error in
            guard let self else { return }
            isLoading.value = false
            if error != nil {
                completion(error)
            } else if let categories {
                dataSource = categories
                mapCellData()
                completion(nil)
            }
        }
    }
    
    private func mapCellData() {
        cellDataSource.value = dataSource?.triviaCategories.compactMap { CategoryCellViewModel($0) }
    }
    
}
