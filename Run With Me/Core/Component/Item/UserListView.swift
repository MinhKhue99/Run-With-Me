//
//  UserListView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 29/03/2023.
//

import SwiftUI

struct UserListView: View {
   
    // MARK: - property
    @ObservedObject var exploreViewModel: ExploreViewModel
    
    // MARK: - body
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(exploreViewModel.searchableUser) { user in
                    NavigationLink {
                        LazyView(ProfileView(user: user))
                    } label: {
                        UserRowView(user: user)
                    }
                }
            }
        }
    }
}
