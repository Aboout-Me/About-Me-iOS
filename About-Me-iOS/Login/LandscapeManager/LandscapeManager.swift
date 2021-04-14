//
//  LandscapeManager.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/04/07.
//

import Foundation

class LandscapeManager {
    static let shared = LandscapeManager()
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: #function)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
}
