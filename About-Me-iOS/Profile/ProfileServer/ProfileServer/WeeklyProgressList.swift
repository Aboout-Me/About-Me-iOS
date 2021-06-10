//
//  WeeklyProgress.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/17.
//

import Foundation

struct WeeklyProgressList: Codable {
    var code: Int
    var message: String
    var date: String
    var weeklyProgressingList: [[WeeklyProgressListModel]]
}

struct WeeklyProgressListModel: Codable {
    var color: String?
    var day: String?
    var isWritten: Bool?
}
