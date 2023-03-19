//
//  ImageUploader.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 08/01/2023.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage?, completion: @escaping (String) -> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.75) else { return }

        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(fileName)")

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
