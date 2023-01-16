//
//  StorageManager.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/16.
//

import Foundation
import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    func get(name: String, completion: @escaping (URL?, Error?) -> Void) {
        let storage = Storage.storage()
        storage.reference(forURL: "gs://contentplayer-a8f09.appspot.com/\(name)").downloadURL(completion: completion)
    }
}
