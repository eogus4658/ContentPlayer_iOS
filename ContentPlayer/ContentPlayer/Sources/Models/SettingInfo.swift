//
//  SettingInfo.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/13.
//

import Foundation

struct SettingInfo: Codable {
    let url: String
    let caption: CaptionSetting
}

struct CaptionSetting: Codable {
    let size: CaptionSize
    let color: CaptionColor
}

enum CaptionSize: Int, Codable {
    case small = 0, medium, large
}

enum CaptionColor: Int, Codable {
    case dark = 0, light
}
