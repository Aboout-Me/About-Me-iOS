//
//  ScrapProgressList.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/06/10.
//

import Foundation

struct ScrapProgressList: Codable {
    var code: Int
    var body: String
    
}

struct ScrapProgressParameter: Encodable {
    var userId: Int
    var questId: Int
}
