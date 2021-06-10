//
//  SocialListResponse.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/25.
//

import Foundation

struct SocialListResponse: Codable {
    let code: Int
    let message: String
    let postList: [SocialPostList]?
}

struct SocialPostList: Codable {
    let answerId: Int
    let color: String
    let question: String
    let userId: Int
    let nickname: String
    let answer: String
    let level: Int
    let likes: Int
    let hasLiked: Bool
    let scraps: Int
    let hasScrapped: Bool
    let comments: Int
    let regDate: String
    let writtenDate: String
}
