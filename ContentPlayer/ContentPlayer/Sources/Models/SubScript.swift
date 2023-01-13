//
//  SubScript.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/13.
//

import Foundation

struct SubScript: Codable {
    let Scripts: [Script]
}

struct Script: Codable {
    let ID: String
    let StartTime: String
    let EndTime: String
    let Korean: String
    let KSLWords: [String]
}
