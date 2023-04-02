//
//  CommentViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 05/03/2023.
//

import Firebase
import FirebaseFirestoreSwift

class CommentViewModel: ObservableObject {
    
    @Published var comments = [Comment]()
    private let post: Post
    
    init(post: Post) {
        self.post = post
        fetchComments()
    }
    
    func uploadComment(commentText: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let postId = post.id else { return }
        let data: [String: Any] = ["username": user.username,
                                   "profileImageUrl": user.profileImageUrl,
                                   "uid": user.id ?? "",
                                   "timestamp": Timestamp(date: Date()),
                                   "postOwnerUid": post.ownerId,
                                   "commentText": commentText]
        
        COLLECTION_POSTS.document(postId)
            .collection("post-comments")
            .addDocument(data: data) {error in
                if let error = error {
                    Logger.shared.debugPrint("\(error)", fuction: "uploadComment")
                    return
                }
            }
        NotificationService.pushNotification(toUid: self.post.ownerId, type: .comment, post: self.post)
    }
    
    func fetchComments() {
        guard let postId = post.id else { return }
        let query = COLLECTION_POSTS
            .document(postId)
            .collection("post-comments")
            .order(by: "timestamp", descending: true)
            
        query.addSnapshotListener {snapshot, _ in
            guard let addDocs = snapshot?.documentChanges.filter({$0.type == .added}) else { return }
            self.comments.append(contentsOf: addDocs.compactMap({try? $0.document.data(as: Comment.self)}))
        }
    }
}
