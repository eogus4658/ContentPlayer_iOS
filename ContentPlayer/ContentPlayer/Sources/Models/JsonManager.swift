//
//  JsonManager.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/09.
//

import Foundation

class JsonManager {
    static let shared = JsonManager()
    private init() {}
    
    func parse<T: Codable>(type: T.Type, json: String) -> T {
        guard let data = json.data(using: .utf8) else {
            fatalError("Json String UTF-8 Encoding Error.")
        }
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(T.self, from: data)
            return data
        } catch {
            fatalError("Parsing Json Struct Error.")
        }
    }
}
