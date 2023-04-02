//
//  PostRowViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 27/01/2023.
//

import Foundation

class PostRowViewModel: ObservableObject {
    @Published var post: Post
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(post: Post) {
        self.post = post
        checkUserLikedPost()
        fetchPostUser()
    }
    
    func likePost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
       COLLECTION_POSTS
            .document(postId)
            .collection("post-likes")
            .document(uid)
            .setData([:]) { _ in
                COLLECTION_USERS
                    .document(uid)
                    .collection("user-likes")
                    .document(postId)
                    .setData([:]) { _ in
                        COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes + 1])
                        NotificationService.pushNotification(toUid: self.post.ownerId, type: .like, post: self.post)
                        self.post.didLike = true
                        self.post.likes += 1
                    }
            }
    }
    
    func unlikePost() {
        guard post.likes > 0 else { return }
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS
            .document(postId)
            .collection("post-likes")
            .document(uid)
            .delete { _ in
                COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
                    COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes - 1])
                    self.post.didLike = false
                    self.post.likes -= 1
                }
            }
    }
    
    func checkUserLikedPost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        COLLECTION_USERS
            .document(uid)
            .collection("user-likes")
            .document(postId)
            .addSnapshotListener {snapshot, _ in
                guard let didLike = snapshot?.exists else { return }
                self.post.didLike = didLike
            }
    }
    
    func fetchPostUser() {
        PostService.fetchPostUser(withUid: post.ownerId) { user in
            self.post.user = user
            print("user: \(String(describing: self.post.user?.username))")
        }
    }
}
