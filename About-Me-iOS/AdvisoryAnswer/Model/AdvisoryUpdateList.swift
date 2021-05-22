//
//  AdvisoryUpdateList.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/22.
//

import Foundation

struct AdvisoryUpdateList: Codable {
    let user: Int
    let stage: Int
    let theme: String
    let theme_new: String
    let answerLists: [AnswerList]
}
