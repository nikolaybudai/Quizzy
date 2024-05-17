//
//  PreviousGamesViewModel.swift
//  Quizzy
//
//  Created by Nikolay Budai on 22/12/23.
//

import Foundation

final class PreviousGamesViewModel: PreviousGamesViewModelProtocol {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[GameCellViewModelProtocol]> = Observable([])
    var dataSource: [Game]?
    
    private let dbManager: DBManagerProtocol
    
    //MARK: Init
    init(dbManager: DBManagerProtocol) {
        self.dbManager = dbManager
        mapCellData()
    }
    
    //MARK: Methods
    func getGames(completion: @escaping (Bool) -> Void) {
        let games = dbManager.getAllGames()
        
        if games?.count == 0 {
            completion(false)
        } else {
            dataSource = games
            mapCellData()
            completion(true)
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    private func mapCellData() {
        cellDataSource.value = dataSource?.map { GameCellViewModel($0) }
    }
}
