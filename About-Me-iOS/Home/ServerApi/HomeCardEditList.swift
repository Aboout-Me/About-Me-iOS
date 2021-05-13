//
//  HomeCardEditList.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/13.
//

import Foundation

//parameter

struct HomeCardEditParamter: Encodable {
    var answer: String
    var category_seq: Int
    var level: Int
    var share: String
}

struct HomeCardEditList: Codable {
    var code: Int
    var message: String
    var user: Int
    var dailyLists: [HomeCardEditListModel]
    var error: String
}

struct HomeCardEditListModel: Codable {
    var cardSeq: Int
    var quest_id: Int
    var question: String
    var answer: String
    var level: Int
    var isShare: String
    var color: String
}

