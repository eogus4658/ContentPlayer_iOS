//
//  String+TimeFormat.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/16.
//

import Foundation

extension String {
    func toSecond() -> Double? {
        // "00:00:01,240" -> 1.24
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss,SSS"
        if let refDate = dateFormatter.date(from: "00:00:00,000"),
           let convertDate = dateFormatter.date(from: self) {
            return convertDate.timeIntervalSince1970 - refDate.timeIntervalSince1970
        } else {
            return nil
        }
    }
}
