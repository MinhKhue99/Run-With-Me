//
//  NewMessageViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/02/2023.
//

import Foundation

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    let userService = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        userService.fetchUsers { users in
            self.users = users
        }
    }
}
