//
//  CategoryProgress.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/17.
//

import Foundation

struct CategoryProgressList: Codable {
    var code: Int
    var data: [CategoryProgressModel]
}

struct CategoryProgressModel: Codable {
    var color: String
    var level: Int
    var experience: Float
}
