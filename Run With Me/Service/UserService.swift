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
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
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
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users")
            .addSnapshotListener {snapshot, error in
                guard let documents = snapshot?.documents else {
                    Logger.shared.debugPrint("Error fetching document: \(String(describing: error?.localizedDescription))", fuction: "fetchUsers")
                    return
                }
                let users = documents.compactMap({try? $0.data(as: User.self)})
                completion(users)
            }
    }
    
    func followUser(withUid uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-following")
            .document(uid)
            .setData([:]) { error in
                COLLECTION_FOLLOWERS.document(uid)
                    .collection("user-followers")
                    .document(uid)
                    .setData([:], completion: completion)
                
            }
    }
    
    func unfollowUser(withUid uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-following")
            .document(uid)
            .delete { error in
                COLLECTION_FOLLOWERS.document(uid)
                    .collection("user-followers")
                    .document(currentUid)
                    .delete(completion: completion)
            }
    }
    
    func checkIfuserIsFollowed(withUid uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-following")
            .document(uid)
            .addSnapshotListener {snapshot, error in
                guard let isFollowed = snapshot?.exists else { return }
                completion(isFollowed)
            }
    }
    
    func fetchUserStats(withUid uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_FOLLOWERS.document(uid)
            .collection("user-followers")
            .getDocuments { snapshot, _ in
                let followers = snapshot?.documents.count ?? 0
                COLLECTION_FOLLOWING.document(uid)
                    .collection("user-following")
                    .addSnapshotListener {snapshot, _ in
                        let followings = snapshot?.documents.count ?? 0
                        completion(UserStats(followers: followers, followings: followings))
                    }
            }
    }
}
