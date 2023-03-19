//
//  PostService.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 26/01/2023.
//

import Firebase
import FirebaseFirestoreSwift
import SwiftUI

struct PostService {
    
    func uploadPost(caption: String,image: UIImage, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) {imageUrl in
            
            let post = ["uid": uid,
                        "caption": caption,
                        "likes": 0,
                        "timestamp": Timestamp(date: Date()),
                        "imageUrl": imageUrl
            ] as [String: Any]
            
            Firestore.firestore().collection("posts").document()
                .setData(post) { error in
                    if let error = error {
                        Logger.shared.debugPrint("Fail uploaded post with error: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    completion(true)
                }
            
        }
    }
    
    //fetch all post to display in newsfeed
    func fetchPosts(completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener {snapshot, error in
                guard let documents = snapshot?.documents else {
                    Logger.shared.debugPrint("Error fetching document: \(String(describing: error?.localizedDescription))", fuction: "fetchPosts")
                    return
                }
                let posts = documents.compactMap({try? $0.data(as: Post.self)})
                completion(posts.sorted(by: {$0.timestamp.compare($1.timestamp) == .orderedDescending }))
            }
    }
    
    //fetch all post of current user to display in profile
    func fetchPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener {snapshot, error in
                guard let documents = snapshot?.documents else {
                    Logger.shared.debugPrint("Error fetching document: \(String(describing: error?.localizedDescription))", fuction: "fetchPosts")
                    return
                }
                let posts = documents.compactMap({try? $0.data(as: Post.self)})
                completion(posts.sorted(by: {$0.timestamp.compare($1.timestamp) == .orderedDescending }))
            }
    }
    
    func likePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        Firestore.firestore().collection("posts").document(postId)
            .updateData(["likes": post.likes +
                         1]) { _ in
                userLikesRef.document(postId).setData([:]) { _ in
                   completion()
                }
            }
    }
    
    func unlikePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }
        guard post.likes > 0 else { return }
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        Firestore.firestore().collection("posts").document(postId)
            .updateData(["likes": post.likes - 1]) { _ in
                userLikesRef.document(postId).delete() { _ in
                   completion()
                }
            }
    }
    
    func checkIfUserLikedPost(_ post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(postId)
            .addSnapshotListener {snapshot, error in
                guard let snapshot = snapshot else {
                    Logger.shared.debugPrint("Error fetching document: \(String(describing: error?.localizedDescription))", fuction: "checkIfUserLikedPost")
                    return
                }
                completion(snapshot.exists)
            }
    }
    
    func fetchLikedPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .addSnapshotListener {snapshot, error in
                guard let documents = snapshot?.documents else {
                    Logger.shared.debugPrint("Error fetching document: \(String(describing: error?.localizedDescription))", fuction: "fetchLikedPosts")
                    return
                }
                documents.forEach { doc in
                    let postId = doc.documentID
                    Firestore.firestore().collection("posts")
                        .document(postId)
                        .addSnapshotListener {snapshot, _ in
                            guard let post = try? snapshot?.data(as: Post.self) else { return }
                            posts.append(post)
                            completion(posts)
                        }
                }
            }
    }
}
