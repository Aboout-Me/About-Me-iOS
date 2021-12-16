//
//  AdminBlockList.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/12/16.
//

import Foundation


struct AdminBlockList: Codable {
    var code:Int
    var body:[AdminBlockModel]
}

struct AdminBlockModel: Codable {
    var boardSeq: Int
    var sueReason: String
    var contents: String
}
