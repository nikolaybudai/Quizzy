//
//  GameViewModelProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 24/10/23.
//

import Foundation

protocol CategoryChoiceViewModelProtocol: AnyObject {
    
    var isLoading: Observable<Bool> { get set }
    var cellDataSource: Observable<[CategoryCellViewModelProtocol]> { get set }
    var dataSource: GetAllCategoriesResponse? { get set }
    
    func numberOfRows(in section: Int) -> Int
    
    func getCategories(_ completion: @escaping (Error?) -> Void)
    
}
