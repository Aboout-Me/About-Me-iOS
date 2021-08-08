//
//  UserProfile.swift
//  오늘의 나
//
//  Created by Apple on 2021/08/08.
//

import Foundation

var USER_ID: Int = UserDefaults.standard.integer(forKey: "USER_ID")
var USER_NICKNAME: String? = UserDefaults.standard.string(forKey: "USER_NICKNAME") ?? nil
