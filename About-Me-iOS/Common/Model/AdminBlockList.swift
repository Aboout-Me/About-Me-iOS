//
//  AdminBlockList.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/12/16.
//

import Foundation


struct AdminBlockList: Codable {
    var code:Int?
    var body:[AdminBlockModel]?
    var errorMessage:String?
    var errorCode: String?
}

struct AdminBlockModel: Codable {
    var boardSeq: Int?
    var title: String?
    var sueReason: String?
    var contents: String?
    var color: String?
}
