//
//  SocialSearchResponse.swift
//  오늘의 나
//
//  Created by Hyeyeon Lee on 2021/07/01.
//

import Foundation

struct SocialSearchResponse: Codable {
    let code: Int
    let message: String
    let postList: [SocialPost]?
}
