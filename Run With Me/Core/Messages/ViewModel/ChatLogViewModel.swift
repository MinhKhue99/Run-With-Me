//
//  ChatLogViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 05/02/2023.
//

import Firebase
import FirebaseSharedSwift

class ChatLogViewModel: ObservableObject {
    
    @Published var message: String = ""
    @Published var msgPhotoUrl: String = ""
    @Published var errorMessage: String = ""
    @Published var chatMessages = [Message]()
    @Published var count = 0
    var firestoreListener: ListenerRegistration?
    
    var chatUser: User?
    
    init(chatUser: User?) {
        self.chatUser = chatUser
        fetchMessages()
    }
    
    func sendMessage() {
        guard let fromId = Auth.auth().currentUser?.uid else { return }
        guard let toId = chatUser?.id else { return }
        
        let messageData = ["fromId": fromId, "toId": toId, "message": self.message, "timestamp": Timestamp()] as [String : Any]
        
        let document = Firestore.firestore().collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let recipientMessageDocument = Firestore.firestore().collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        document.setData(messageData) {error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                Logger.shared.debugPrint(error.localizedDescription, fuction: "sendMessage")
                return
            }
            
            self.persistResentMessage()
            
            self.message = ""
            self.count += 1
        }
        
        recipientMessageDocument.setData(messageData) {error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                Logger.shared.debugPrint(error.localizedDescription, fuction: "sendMessage")
                return
            }
        }
        
    }
    
    private func persistResentMessage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let toId = chatUser?.id else { return }
        
        let document = Firestore.firestore().collection("recent-messages")
            .document(uid)
            .collection("messages")
            .document(toId)
        
        let data = ["timestamp": Timestamp(),
                    "message": self.message,
                    "fromId": uid,
                    "toId": toId,
                    "profileImageUrl": chatUser?.profileImageUrl ?? "",
                    "fullname": chatUser?.fullname ?? ""
        ] as [String : Any]
        
        document.setData(data) { error in
            if let error = error {
                Logger.shared.debugPrint(error.localizedDescription, fuction: "persistResentMessage")
                self.errorMessage = error.localizedDescription
                return
            }
        }
    }
    
    func fetchMessages() {
        guard let fromId = Auth.auth().currentUser?.uid else { return }
        guard let toId = chatUser?.id else { return }
        firestoreListener?.remove()
        chatMessages.removeAll()
        
        firestoreListener = Firestore.firestore().collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener {querySnapshot, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    Logger.shared.debugPrint(error.localizedDescription, fuction: "sendMessage")
                    return
                }
                querySnapshot?.documentChanges.forEach { change in
                    if change.type == .added {
                        if let message = try? change.document.data(as: Message.self) {
                            self.chatMessages.append(message)
                        }
                        
                        
                    }
                }
                DispatchQueue.main.async {
                    self.count += 1
                }
            }
    }
}
