//
//  NotificationViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 17/03/2023.
//

import Firebase
import FirebaseFirestoreSwift

class NotificationViewModel: ObservableObject {
    
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotification()
    }
    
    func fetchNotification() {
        NotificationService.fetchNotification {notifications in
            self.notifications = notifications
        }
    }
}
