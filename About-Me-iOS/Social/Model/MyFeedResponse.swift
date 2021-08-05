//
//  MyFeedResponse.swift
//  오늘의 나
//
//  Created by Hyeyeon Lee on 2021/07/07.
//

import Foundation

struct MyFeedResponse: Codable {
    let code: Int
    let message: String
    let postList: [FeedPost]
}

struct FeedPost: Codable {
    let answerId: Int
    let color: String
    let level: Int
    let question: String
    let answer: String
    let shareYN: Bool
    let regDate: String
    let writtenDate: String
}
