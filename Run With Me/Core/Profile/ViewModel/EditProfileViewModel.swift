//
//  PostFillterViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    private let user: User
    @Published var uploadCompleted = false
    init(user: User) {
        self.user = user
    }
    
    func saveUserBio(_ bio: String) {
        guard let uid = user.id else { return }
        
        COLLECTION_USERS
            .document(uid)
            .updateData(["bio": bio]) { _ in
                self.uploadCompleted = true
            }
    }
}
