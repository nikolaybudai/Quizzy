//
//  GetQuestionsResponse.swift
//  Quizzy
//
//  Created by Nikolay Budai on 29/10/23.
//

import Foundation

struct GetQuestionsResponse: Decodable {
    let responseCode: Int
    let results: [Question]
}
