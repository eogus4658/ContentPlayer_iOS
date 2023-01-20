//
//  UserManager.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/20.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private init() {}
    
    var settingInfo: SettingInfo? {
        get {
            if let settingData = UserDefaults.standard.data(forKey: "setting") {
                let settingInfo = JsonManager.shared.parse(type: SettingInfo.self, data: settingData)
                return settingInfo
            } else { return nil }
        }
    }
}
