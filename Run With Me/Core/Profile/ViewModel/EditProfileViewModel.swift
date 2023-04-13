//
//  PostFillterViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var uploadCompleted = false
    init(user: User) {
        self.user = user
    }
    
    func saveUserBio(_ bio: String, email: String, username: String, fullname: String, image: UIImage) {
        guard let uid = user.id else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { profileImageUrl in
            COLLECTION_USERS
                .document(uid)
                .updateData(["bio": bio,
                             "email": email,
                             "fullname": fullname,
                             "profileImageUrl": profileImageUrl,
                             "username": username
                            ]) { _ in
                    self.uploadCompleted = true
                }
        }
    }
}
