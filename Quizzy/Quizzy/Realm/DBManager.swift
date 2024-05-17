//
//  DBManager.swift
//  Quizzy
//
//  Created by Nikolay Budai on 06/12/23.
//

import Foundation
import RealmSwift

final class DBManager: DBManagerProtocol {
    
    private func getRealm() throws -> Realm {
        let config = Realm.Configuration(schemaVersion: 2)
        Realm.Configuration.defaultConfiguration = config
        
        do {
            return try Realm()
        } catch let error {
            throw error
        }
    }
    
    func save(_ game: Game) {
        do {
            let realm = try getRealm()
            let existingGames = getAllGames()
            
            try realm.write {
                if existingGames?.count ?? 0 > 20,
                   let oldestGame = existingGames?.last {
                    delete(oldestGame)
                }
                realm.add(game)
            }
        } catch {
            print("Error while saving realm object: \(error.localizedDescription)")
        }
    }
    
    func delete(_ game: Game) {
        do {
            let realm = try getRealm()
            try realm.write {
                realm.delete(game)
            }
        } catch {
            print("Error while deleting realm object: \(error.localizedDescription)")
        }
    }
    
    func getAllGames() -> [Game]? {
        var games = [Game]()
        do {
            let realm = try getRealm()
            games = Array(realm.objects(Game.self).sorted(byKeyPath: "date", ascending: false))
        } catch {
            print("Error while getting games from realm: \(error.localizedDescription)")
        }
        return games
    }
    
}
