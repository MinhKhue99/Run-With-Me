//
//  NotificationViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 17/03/2023.
//

import Firebase
import FirebaseFirestoreSwift

class NotificationViewModel: ObservableObject {
    
    let notificationService = NotificationService()
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotification()
        Logger.shared.debugPrint("noti: \(notifications)")
    }
    func fetchNotification() {
        notificationService.fetchNotification {notifications in
            self.notifications = notifications
        }
    }
}
