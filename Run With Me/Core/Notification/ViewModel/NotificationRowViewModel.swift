//
//  NotificationRowViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 01/04/2023.
//

import Firebase

class NotificationRowViewModel: ObservableObject {
    
    @Published var notification: Notification
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(notification: Notification) {
        self.notification = notification
        checkIfUserIsFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    
    func followUser() {
        UserService.followUser(withUid: notification.uid) { _ in
                self.notification.isFollowed = true
            NotificationService.pushNotification(toUid: self.notification.uid, type: .follow)
        }
    }
    
    func unfollowUser() {
        UserService.unfollowUser(withUid: notification.uid) { _ in
                self.notification.isFollowed = false
        }
    }
    
    
    func checkIfUserIsFollowed() {
        guard notification.type == .follow else { return }
        UserService.checkIfuserIsFollowed(withUid: notification.uid) { isFollowed in
                self.notification.isFollowed = isFollowed
        }
    }
    
    func fetchNotificationPost() {
        guard let postId = notification.postId else { return }
        NotificationService.fetchNotificationPost(postId: postId) { post in
            self.notification.post = post
        }
    }
    
    func fetchNotificationUser() {
        NotificationService.fetchNotificationUser(withUid: notification.uid) { user in
            self.notification.user = user
            print("user: \(String(describing: self.notification.user?.username))")
        }
    }
}
