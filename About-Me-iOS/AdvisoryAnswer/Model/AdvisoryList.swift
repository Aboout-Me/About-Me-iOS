//
//  AdvisoryList.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/29.
//

import Foundation

struct AdvisoryList: Codable {
    let user: Int
    let themeLists: [ThemeList]
}

struct ThemeList: Codable {
    let stage_num: String
    let stage_name: String
    let rate: String
    let timer: String
}
