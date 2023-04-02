//
//  NotificationService.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 16/03/2023.
//

import Firebase
import FirebaseFirestoreSwift
import SwiftUI

struct NotificationService {
    
    static func pushNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard uid != user.id else { return }
        var data: [String: Any] = [
            "username": user.username,
            "profileImageUrl": user.profileImageUrl,
            "timestamp": Timestamp(date: Date()),
            "type": type.rawValue,
            "uid": user.id ?? ""]
        
        if let post = post, let id = post.id {
            data["postId"] = id
        }
        
        COLLECTION_NOTIFICATIONS
            .document(uid)
            .collection("user-notifications")
            .addDocument(data: data)
        
    }
    
    static func fetchNotification(completion: @escaping([Notification]) -> Void) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        
        let query = COLLECTION_NOTIFICATIONS
            .document(uid)
            .collection("user-notifications")
            .order(by: "timestamp", descending: true)
        query.getDocuments { snapshot, _ in
            guard let documments = snapshot?.documents else { return }
            let notifications = documments.compactMap({try? $0.data(as: Notification.self)})
            completion(notifications)
        }
    }
    
    static func fetchNotificationPost(postId: String, completion: @escaping(Post?) -> Void) {
        COLLECTION_POSTS
            .document(postId)
            .getDocument { snapshot, _ in
                let post = try? snapshot?.data(as: Post.self)
                completion(post)
            }
    }
    
    static func fetchNotificationUser(withUid uid: String, completion: @escaping(User?) -> Void) {
        COLLECTION_USERS
            .document(uid)
            .getDocument {snapshot, _ in
                let user = try? snapshot?.data(as: User.self)
                completion(user)
            }
    }
}
