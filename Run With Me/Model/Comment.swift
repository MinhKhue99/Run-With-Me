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
    let uid: String
    let timestamp: Timestamp
    let postOwnerUid: String
    let commentText: String
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
    
}
