//
//  Comment.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 21/02/2023.
//

import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp?
    let comment: String
}
