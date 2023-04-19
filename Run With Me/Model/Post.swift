//
//  Post.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 26/01/2023.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {
    
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    let imageUrl: String
    let ownerId: String
    let ownerImageUrl: String
    let ownerUsername: String
    
    var user: User?
    var didLike: Bool? = false
}
