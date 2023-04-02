//
//  UserService.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 10/01/2023.
//

import Firebase
import FirebaseFirestoreSwift


typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS
            .document(uid)
            .addSnapshotListener {snapshot, error in
                guard let snapshot = snapshot else {
                    Logger.shared.debugPrint("Error fetching document: \(String(describing: error?.localizedDescription))", fuction: "fetchUser")
                    return
                }
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS
            .addSnapshotListener {snapshot, error in
                guard let documents = snapshot?.documents else {
                    Logger.shared.debugPrint("Error fetching document: \(String(describing: error?.localizedDescription))", fuction: "fetchUsers")
                    return
                }
                let users = documents.compactMap({try? $0.data(as: User.self)})
                completion(users)
            }
    }
    
    static func followUser(withUid uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-followings")
            .document(uid)
            .setData([:]) { _ in
                COLLECTION_FOLLOWERS.document(uid)
                    .collection("user-followers")
                    .document(currentUid)
                    .setData([:], completion: completion)
                
            }
    }
    
   static  func unfollowUser(withUid uid: String, completion: @escaping(FirestoreCompletion)) {
       guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-followings")
            .document(uid)
            .delete { _ in
                COLLECTION_FOLLOWERS.document(uid)
                    .collection("user-followers")
                    .document(currentUid)
                    .delete(completion: completion)
            }
    }
    
    static func checkIfuserIsFollowed(withUid uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-followings")
            .document(uid)
            .addSnapshotListener {snapshot, error in
                guard let isFollowed = snapshot?.exists else { return }
                completion(isFollowed)
            }
    }
    
    static func fetchUserStats(withUid uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_FOLLOWING.document(uid)
            .collection("user-followings")
            .getDocuments { snapshot, _ in
                let followings = snapshot?.documents.count ?? 0
                COLLECTION_FOLLOWERS.document(uid)
                    .collection("user-followers")
                    .getDocuments {snapshot, _ in
                        let followers = snapshot?.documents.count ?? 0
                        COLLECTION_POSTS
                            .whereField("ownerId", isEqualTo: uid)
                            .getDocuments {snapshot, _ in
                                let post = snapshot?.documents.count ?? 0
                                completion(UserStats(followers: followers, followings: followings, posts: post))
                            }
                    }
            }
    }
}
