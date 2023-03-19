//
//  Notification.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 16/03/2023.
//

import FirebaseFirestoreSwift
import Firebase

enum NotificationType: Int, Decodable {
    case like
    case follow
    case comment
    case message
    
    var notificationMessage: String {
        switch self {
        case .like: return "liked your post"
        case .comment: return "commented on your post"
        case .follow: return "started following you"
        case .message: return "You have a new message"
        }
    }
}

struct Notification: Identifiable, Decodable {
    @DocumentID var uid: String?
    var postImageUrl: String?
    var postId: String?
    let timestamp: Timestamp
    let type: NotificationType
    let id: String
}
