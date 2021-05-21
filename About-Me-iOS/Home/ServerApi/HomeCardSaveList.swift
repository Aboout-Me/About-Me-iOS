//
//  HomeCardSaveList.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/10.
//

import Foundation

struct HomeCardSaveParamter: Encodable {
    var answer: String
    var color: String
    var level: Int
    var share_yn: String
    var title: Int
    var user: Int
}

struct HomeCardSaveList: Codable {
    var code: Int
    var message: String
    var user: Int
    var dailyLists: [HomeCardSaveListModel]
}

struct HomeCardSaveListModel: Codable {
    var cardSeq: Int
    var quest_id: Int
    var question: String
    var answer: String
    var level: Int
    var isShare: String
    var color: String
}
