//
//  MyProfilePage.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/25.
//

import Foundation

struct MyProfilePage: Codable {
    var code: Int
    var message: String
    var user_id: Int
    var nickName: String
    var introduce: String
    var color: String
    var color_tag: String
    var postList: [MyProfilePageModel]
}

struct MyProfilePageModel: Codable {
    var answerId: Int
    var color: String
    var level: Int
    var question: String
    var answer: String
    var shareYN: Bool
    var regDate: String
    var writtenDate: String
}
