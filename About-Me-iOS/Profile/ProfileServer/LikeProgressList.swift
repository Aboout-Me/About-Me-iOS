//
//  LikeProgressList.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/06/09.
//

import Foundation

struct LikeProgressList: Codable {
    var code: Int
    var body: String
}

struct LikeProgressParameter: Encodable {
    var userId: Int
    var questId: Int
}
