//
//  MessagesViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/02/2023.
//

import Firebase
import FirebaseFirestoreSwift

class MessagesViewModel: ObservableObject {
    @Published var chatUser: User?
    @Published var recentMessages = [RecentMessage]()
    private var firestoreListener: ListenerRegistration?
    
    init() {
        fetchRecentMessages()
    }
    
    private func fetchRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        firestoreListener?.remove()
        self.recentMessages.removeAll()
        
        Firestore.firestore().collection("recent-messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener {querySnapshot, _ in
                querySnapshot?.documentChanges.forEach {change in
                    
                    let docId = change.document.documentID
                    if let index = self.recentMessages.firstIndex(where: {rm in
                        return rm.id == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    
                    if let rm = try? change.document.data(as: RecentMessage.self) {
                        self.recentMessages.insert(rm, at: 0)
                    }
                }
            }
    }
}
