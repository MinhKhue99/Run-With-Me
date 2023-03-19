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
    
    func pushNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUid else { return }
        
        let docRef = COLLECTION_NOTIFICATIONS.document(uid)
            .collection("user-notifications").document()
        
        var data: [String: Any] = [
            "timestamp": Timestamp(date: Date()),
            "uid": currentUid,
            "type": type.rawValue,
            "id": docRef.documentID]
        
        if let post = post {
            data["postId"] = post.id
            data["postImageUrl"] = post.imageUrl
        }
        
        docRef.setData(data)
        
    }
    
    func fetchNotification(completion: @escaping([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_NOTIFICATIONS.document(uid)
            .collection("user-notifications")
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let notifications = documents.compactMap({try? $0.data(as: Notification.self)})
                completion(notifications)
            }
    }
}
