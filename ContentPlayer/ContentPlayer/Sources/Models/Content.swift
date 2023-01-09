//
//  Content.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/09.
//

import Foundation

struct Contents: Codable {
    let Contents: [Content]
}

struct Content: Codable {
    let Genre: String
    let Name: String
    let Description: String
    let Definition: String
    let VideoPath: String
    let ThumbPath: String
    let ScriptPath: String
    let CaptionPath: String
}
