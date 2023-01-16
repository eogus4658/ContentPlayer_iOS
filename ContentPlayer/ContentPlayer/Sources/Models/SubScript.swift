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

extension SubScript {
    func currentScript(time: Double) -> String? {
        for script in Scripts where script.isTimeAvailable(time: time) {
            return script.Korean
        }
        return nil
    }
}

struct Script: Codable {
    let ID: String
    let StartTime: String
    let EndTime: String
    let Korean: String
    let KSLWords: [String]
}

extension Script {
    func isTimeAvailable(time: Double) -> Bool {
        if let start = StartTime.toSecond(),
           let end = EndTime.toSecond() {
            return start < time && time < end
        } else {
            return false
        }
    }
}
