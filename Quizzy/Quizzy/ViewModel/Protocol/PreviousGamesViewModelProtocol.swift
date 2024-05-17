//
//  PreviousGamesViewModelProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 22/12/23.
//

import Foundation

protocol PreviousGamesViewModelProtocol {
    
    var isLoading: Observable<Bool> { get set }
    var cellDataSource: Observable<[GameCellViewModelProtocol]> { get set }
    var dataSource: [Game]? { get set }
    
    func numberOfRows(in section: Int) -> Int
    
    func getGames(completion: @escaping (Bool) -> Void)
}
