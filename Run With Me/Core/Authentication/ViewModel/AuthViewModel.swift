//
//  AuthViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 08/01/2023.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticateUser = false
    @Published var currentUser: User?
    private var tempUserSession: FirebaseAuth.User?
    static let shared = AuthViewModel()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    //MARK: - Login
    func login(withEmail email: String, password: String, onError: @escaping(_ error: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                Logger.shared.debugPrint("DEBUG: Failed to login with error \(error.localizedDescription)", fuction: "login")
                onError(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    //MARK: - Register
    func register(withEmail email: String, username: String, fullname: String, password: String, onError: @escaping(_ error: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
            
            let userData = ["email": email,
                            "username": username.lowercased(),
                            "fullname": fullname,
                            "uid": user.uid]
            
            COLLECTION_USERS
                .document(user.uid)
                .setData(userData) { _ in
                    self.isAuthenticateUser = true
                }
        }
    }
    
    //MARK: - Logout
    func logout() {
        isAuthenticateUser = false
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { profileImageUrl in
            COLLECTION_USERS
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        UserService.fetchUser(withUid: uid) {user in
            self.currentUser = user
        }
    }
}
