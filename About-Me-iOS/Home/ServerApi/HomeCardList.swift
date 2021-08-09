//
//  HomeCardList.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/08.
//

import Foundation


struct HomeCardList: Codable {
    var code: Int
    var message: String
    var user: Int
    var dailyLists: [HomeCardListModel]
}

struct HomeCardListModel: Codable {
    var seq: Int
    var lev: String
    var color: String
    var question: String
    
    enum CodingKeys: String,CodingKey {
        case seq
        case lev = "lev."
        case color
        case question
    }
  
}

struct HomeWriteCardList: Codable {
    var code: Int
    var message: String
    var isWritten: Bool
}
