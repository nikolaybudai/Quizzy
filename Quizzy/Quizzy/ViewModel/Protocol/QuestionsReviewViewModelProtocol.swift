//
//  QuestionsReviewViewModelProtocol.swift
//  Quizzy
//
//  Created by Nikolay Budai on 14/12/23.
//

import Foundation

protocol QuestionsReviewViewModelProtocol {
    var cellDataSource: Observable<[QuestionCellViewModelProtocol]> { get set }
    var dataSource: [QuestionReview] { get set }
    
    func numberOfRows(in section: Int) -> Int
}
