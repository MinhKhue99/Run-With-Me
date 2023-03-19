//
//  PostRowViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 27/01/2023.
//

import Foundation

class PostRowViewModel: ObservableObject {
    private let postService = PostService()
    private let notificationService = NotificationService()
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
        checkUserLikedPost()
    }
    
    func likePost() {
        postService.likePost(post) {
            self.post.didLike = true
            self.notificationService.pushNotification(toUid: self.post.id!, type: .like, post: self.post)
        }
    }
    
    func unlikePost() {
        postService.unlikePost(post) {
            self.post.didLike = false
        }
    }
    
    func checkUserLikedPost() {
        postService.checkIfUserLikedPost(post) { didLike in
            if didLike {
                self.post.didLike = true
            }
        }
    }
}
