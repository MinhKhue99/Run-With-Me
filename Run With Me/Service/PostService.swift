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
        guard let user = AuthViewModel.shared.currentUser else { return }
        ImageUploader.uploadImage(image: image, type: .post) {imageUrl in
            
            let post = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerId": user.id as Any,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username
            ] as [String: Any]
            
            COLLECTION_POSTS.document()
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
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS
            .order(by: "timestamp", descending: true)
            .getDocuments {snapshot, error in
                guard let documents = snapshot?.documents else {
                    Logger.shared.debugPrint("Error fetching document: \(String(describing: error?.localizedDescription))", fuction: "fetchPosts")
                    return
                }
                let posts = documents.compactMap({try? $0.data(as: Post.self)})
                completion(posts.sorted(by: {$0.timestamp.compare($1.timestamp) == .orderedDescending }))
            }
    }
    
    //fetch all post of current user to display in profile
    static func fetchPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS
            .whereField("ownerId", isEqualTo: uid)
            .getDocuments {snapshot, error in
                guard let documents = snapshot?.documents else {
                    Logger.shared.debugPrint("Error fetching document: \(String(describing: error?.localizedDescription))", fuction: "fetchPosts")
                    return
                }
                let posts = documents.compactMap({try? $0.data(as: Post.self)})
                completion(posts.sorted(by: {$0.timestamp.compare($1.timestamp) == .orderedDescending }))
            }
    }
    
    //fetch all post of current user to display in explore
    static func fetchPostUser(withUid uid: String, completion: @escaping(User?) -> Void) {
        COLLECTION_USERS
            .document(uid)
            .getDocument {snapshot, _ in
                let user = try? snapshot?.data(as: User.self)
                completion(user)
            }
    }
   
}
