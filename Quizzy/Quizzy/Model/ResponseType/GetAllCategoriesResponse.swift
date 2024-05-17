//
//  GetAllCategoriesResponse.swift
//  Quizzy
//
//  Created by Nikolay Budai on 26/10/23.
//

import Foundation

struct GetAllCategoriesResponse: Decodable {
    let triviaCategories: [Category]
}
