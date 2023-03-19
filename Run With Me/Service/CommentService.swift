//
//  CommentService.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 21/02/2023.
//

import Firebase
import FirebaseFirestoreSwift

struct CommentService {
    
    func uploadComment(comment: String, postId: String, user: User, completion: @escaping(FirestoreCompletion)) {
        let data = ["uid": user.id as Any,
                    "comment": comment,
                    "timestamp": Timestamp(date: Date()),
                    "username": user.username,
                    "profileImageUrl": user.profileImageUrl] as [String : Any]
        
        COLLECTION_POSTS.document(postId)
            .collection("comments")
            .addDocument(data: data, completion: completion)
    }
    
    
    func fetchComment(forPost postId: String, completion: @escaping([Comment]) -> Void) {
        var comments = [Comment]()
        let query = COLLECTION_POSTS.document(postId)
            .collection("comments")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener {snapshot, error in
            snapshot?.documentChanges.forEach({change in
                if change.type == .added {
                    if let comment = try? change.document.data(as: Comment.self) {
                        comments.append(comment)
                    }
                }
            })
            completion(comments)
        }
    }
}
