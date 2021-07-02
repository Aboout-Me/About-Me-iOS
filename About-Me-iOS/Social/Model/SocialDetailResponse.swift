//
//  SocialDetailResponse.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/06/03.
//

import Foundation

struct SocialDetailResponse: Codable {
    let code: Int
    let message: String
    let post: SocialPost
    let comments: [SocialComment]
}

struct SocialPost: Codable {
    let answerId: Int
    let color: String
    let question: String
    let userId: Int
    let nickname: String
    let answer: String
    let shareYN: Bool
    let level: Int
    let likes: Int
    let hasLiked: Bool
    let scraps: Int
    let hasScrapped: Bool
    let comments: Int
    let regDate: String
    let writtenDate: String
}

struct SocialComment: Codable {
    let commentId: Int
    let answerId: Int
    let authorId: Int
    let nickname: String
    let regDate: String
    let writtenDate: String
    let comment: String
}
