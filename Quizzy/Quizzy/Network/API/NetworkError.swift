//
//  NetworkError.swift
//  Quizzy
//
//  Created by Nikolay Budai on 31/10/23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case cannotParseData
    case jsonError
}
