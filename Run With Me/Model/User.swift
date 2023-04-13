//
//  User.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 12/01/2023.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    var username: String
    var fullname: String
    var profileImageUrl: String
    var email: String
    var bio: String?
    var isCurrentUser: Bool {
        return AuthViewModel.shared.userSession?.uid == id
    }
    var isFollowed: Bool? = false
    var stats: UserStats?
}
