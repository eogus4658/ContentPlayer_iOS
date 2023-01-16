//
//  Content.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/09.
//

import UIKit
import FirebaseStorage

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

extension Content {
    func image() async -> UIImage? {
        let storage = Storage.storage()
        guard let url = try? await storage.reference(forURL: "gs://contentplayer-a8f09.appspot.com/\(self.ThumbPath)").downloadURL(),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
}
