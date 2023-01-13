//
//  Int+TimeFormat.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/13.
//

import Foundation

extension Int {
    func timeFormat() -> String {
        let hr: Int = self / 3600
        let min: Int = (self % 3600) / 60
        let sec: Int = self % 60
        return "\(String(format: "%02d", hr)):\(String(format: "%02d", min)):\(String(format: "%02d", sec))"
    }
}
