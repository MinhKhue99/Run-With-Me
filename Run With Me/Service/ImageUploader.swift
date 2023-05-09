//
//  ImageUploader.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 08/01/2023.
//

import UIKit
import FirebaseStorage

enum UploadType {
    case profile
    case post
    case message
    
    var choseFilePath: StorageReference {
        let fileName = NSUUID().uuidString
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_image/\(fileName)")
        case .post:
            return Storage.storage().reference(withPath: "/post/\(fileName)")
        case .message:
            return Storage.storage().reference(withPath: "/message/\(fileName)")
        }
    }
}

struct ImageUploader {
    static func uploadImage(image: UIImage?, type: UploadType, completion: @escaping (String) -> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.75) else { return }
        
        let ref = type.choseFilePath
        ref.putData(imageData, metadata: nil) {_, error in
            if let error = error {
                Logger.shared.debugPrint("Fail to upload image with error \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL {imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
