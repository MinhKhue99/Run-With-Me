//
//  RecentMessage.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 10/02/2023.
//

import Firebase
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
    @DocumentID var id: String? 
    let message: String
    let fromId: String
    let toId: String
    let fullname: String
    let profileImageUrl: String
    let timestamp: Date
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
