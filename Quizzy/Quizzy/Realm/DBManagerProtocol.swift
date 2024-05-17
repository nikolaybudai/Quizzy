//
//  DBManagerProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 06/12/23.
//

import Foundation

protocol DBManagerProtocol {
    func save(_ game: Game)
    func delete(_ game: Game)
    func getAllGames() -> [Game]?
}
