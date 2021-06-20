//
//  AdvisoryDetailList.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/19.
//

import Foundation

struct AdvisoryDetailList: Codable {
    let code: Int
    let message: String
    let user: Int
    let theme: String
    let stage: Int
    let answerLists: [AdvisoryAnswerList]
}

struct AdvisoryAnswerList: Codable {
    let seq: Int
    let levels: String
    let question: String
    let answer: String
    let postOn: String
}
