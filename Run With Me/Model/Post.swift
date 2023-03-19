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
    let timestamp: Date
    let uid: String
    let imageUrl: String
    var likes: Int
    var user: User?
    var didLike: Bool? = false
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
