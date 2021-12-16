//
//  UtilModelList.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/06/28.
//

import Foundation

struct UtilModelList: Codable {
    var code: Int
    var message: String
    var post: UtilModel
    var comments: [UtilCommentModel]
}

struct UtilModel: Codable {
    var answerId: Int
    var color: String
    var question: String
    var userId: Int
    var nickname: String
    var answer: String
    var shareYN: Bool
    var level: Int
    var likes: Int
    var hasLiked: Bool
    var scraps: Int
    var hasScrapped: Bool
    var comments: Int
    var regDate: String
    var writtenDate: String
}

struct UtilCommentModel: Codable {
    var commentId: Int
    var answerId: Int
    var authorId: Int
    var color: String
    var nickname: String
    var regDate: String
    var writtenDate: String
    var comment: String
}


