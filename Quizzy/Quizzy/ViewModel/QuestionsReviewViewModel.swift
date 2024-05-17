//
//  QuestionsReviewViewModel.swift
//  Quizzy
//
//  Created by Nikolay Budai on 14/12/23.
//

import Foundation

final class QuestionsReviewViewModel: QuestionsReviewViewModelProtocol {
    
    var cellDataSource: Observable<[QuestionCellViewModelProtocol]> = Observable([])
    var dataSource: [QuestionReview]
    
    //MARK: Init
    init(questionsWithAnswers: [QuestionReview]) {
        self.dataSource = questionsWithAnswers
        mapCellData()
    }
    
    //MARK: Methods
    func numberOfRows(in section: Int) -> Int {
        return dataSource.count
    }
    
    private func mapCellData() {
        cellDataSource.value = dataSource.map { QuestionCellViewModel($0) }
    }
    
}
