//
//  LastAnswerList.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/06/27.
//

import Foundation

struct LastAnswerCardList: Codable {
    var code: Int
    var message: String
    var postList: [LastAnswerListModel]
    
}

struct LastAnswerListModel: Codable {
    var answerId: Int
    var question: String
    var color: String
    var answer: String
    var level: Int
}
