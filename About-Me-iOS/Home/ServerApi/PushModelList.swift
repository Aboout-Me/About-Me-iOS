//
//  PushModelList.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/08/01.
//

import Foundation


struct PushModelList: Codable {
    var code: Int
    var body: [PushModelDataList]
}

struct PushModelDataList: Codable {
    var color: String
    var message: String
    var updateDate: String
}
