//
//  ExploreViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 25/01/2023.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    let userService = UserService()
    
    init() {
        fetchUsers()
    }
    
    var searchableUser: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowcasedQuery = searchText.lowercased()
            return users.filter({
                $0.username.contains(lowcasedQuery) ||
                $0.fullname.lowercased().contains(lowcasedQuery)
            })
        }
    }
    
    func fetchUsers() {
        userService.fetchUsers { users in
            self.users = users
        }
    }
}
