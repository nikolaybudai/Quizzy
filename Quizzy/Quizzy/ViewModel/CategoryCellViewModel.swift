//
//  CategoryCellViewModel.swift
//  Quizzy
//
//  Created by Nikolay Budai on 31/10/23.
//

import Foundation

final class CategoryCellViewModel: CategoryCellViewModelProtocol {
    
    var name: String
    
    //MARK: Init
    init(_ category: Category) {
        self.name = category.name
    }
    
}
