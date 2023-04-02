//
//  ProfileViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 27/01/2023.
//

import Firebase
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var likedPosts = [Post]()
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    func followUser() {
        guard let uid = user.id else { return }
        UserService.followUser(withUid: uid) { _ in
            self.user.isFollowed = true
            NotificationService.pushNotification(toUid: uid, type: .follow)
        }
    }
    
    func unfollowUser() {
        guard let uid = user.id else { return }
        UserService.unfollowUser(withUid: uid) { _ in
            self.user.isFollowed = false
        }
    }
    
    
    func checkIfUserIsFollowed() {
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        UserService.checkIfuserIsFollowed(withUid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    func fetchUserStats() {
        guard let uid = user.id else { return }
        UserService.fetchUserStats(withUid: uid) {stats in
            self.user.stats = stats
        }
    }
    
}
