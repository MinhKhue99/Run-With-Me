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
    private let postService = PostService()
    private let userService = UserService()
    var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserPosts()
        fetchLikedPost()
        fetchUserStats()
    }
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
            
        }
        return self.user.isFollowed ?? true ? "Follow" : "Following"
    }
    
    var followButtonBackgroudColor: Color {
        return user.isCurrentUser ? .white : Color(.systemBlue)
    }
    
    var followButtonTextColor: Color {
        return user.isCurrentUser ? .black : .white
    }
    
    func filterPost(forFilter filter: PostFilterViewModel) -> [Post] {
        switch filter {
        case.posts:
            return posts
        case .replies:
            return posts
        case .likes:
            return likedPosts
        }
    }
    
    func fetchUserPosts() {
        guard let uid = user.id else { return }
        postService.fetchPosts(forUid: uid) { posts in
            self.posts = posts
            for index in 0..<posts.count {
                self.posts[index].user = self.user
            }
        }
    }
    
    func fetchLikedPost() {
        guard let uid = user.id else { return }
        postService.fetchLikedPosts(forUid: uid) { posts in
            self.likedPosts = posts
            for index in 0 ..< posts.count {
                let uid = posts[index].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedPosts[index].user = user
                }
            }
        }
    }
    
    func followUser() {
        guard let uid = user.id else { return }
        userService.followUser(withUid: uid) { result in
            self.user.isFollowed = true
        }
    }
    
    func unfollowUser() {
        guard let uid = user.id else { return }
        userService.unfollowUser(withUid: uid) { result in
            self.user.isFollowed = false
        }
    }
    
    
    func checkIfUserIsFollowed() {
        guard let uid = user.id else { return }
        userService.checkIfuserIsFollowed(withUid: uid) {isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    func fetchUserStats() {
        guard let uid = user.id else { return }
        userService.fetchUserStats(withUid: uid) {stats in
            self.user.stats = stats
            Logger.shared.debugPrint("stats: \(stats)")
        }
    }
    
}
