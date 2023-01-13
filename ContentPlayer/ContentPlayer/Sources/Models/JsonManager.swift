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
    
    func parse<T: Codable>(type: T.Type, data: Data) -> T {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(T.self, from: data)
            return data
        } catch {
            fatalError("Parsing Json Struct Error.")
        }
    }
    
    func encode<T: Codable>(from data: T) -> Data {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(data)
        } catch {
            fatalError("Encoding Struct to Json Error.")
        }
    }
}
