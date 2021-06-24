//
//  MyProfileLikeScrapList.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/06/02.
//

import Foundation

struct MyProfileLikeScrapList: Codable {
    var code: Int
    var message: String
    var user_id: Int
    var nickName: String
    var introduce: String
    var color: String
    var color_tag: String
    var postList: [MyProfileLikeScrapModel]
    
}

struct MyProfileLikeScrapModel: Codable {
    var errorCode: String?
    var body: [MyProfileLikeScrapModelBody]?
    
}

struct MyProfileLikeScrapModelBody: Codable {
    var boardSeq: Int
    var question: String
    var color: String
    var answer: String
    var level: Int
    var likes: Int
    var scraps: Int
    var hasLiked: Bool
    var hasScraped: Bool
    var shareYN: Bool
    var commentCount: Int
    var updateDate: String
}
