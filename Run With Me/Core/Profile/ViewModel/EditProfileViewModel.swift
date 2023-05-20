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
    
    func updateUserInfo(bio: String, email: String, username: String, fullname: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let currentEmail = user.email
        let currentUser = Auth.auth().currentUser
        
        if email != currentEmail {
            currentUser?.updateEmail(to: email) { error in
                if let error = error {
                    Logger.shared.debugPrint("\(error.localizedDescription)", fuction: "updateUserInfo")
                }
            }
        }
        
        COLLECTION_USERS
            .document(uid)
            .updateData(["bio": bio,
                         "email": email,
                         "fullname": fullname,
                         "username": username
                        ]) { _ in
                self.uploadCompleted = true
            }
    }
    
    
    func updateUserImage(image: UIImage?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image, type: .profile) { profileImageUrl in
            COLLECTION_USERS
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl,]) { _ in
                    self.uploadCompleted = true
                }
        }
    }
}
