    //
    //  ExploreView.swift
    //  Run With Me
    //
    //  Created by Phạm Minh Khuê on 02/01/2023.
    //

import SwiftUI

struct ExploreView: View {
    
    // MARK: - property
    @ObservedObject private var exploreViewModel = ExploreViewModel()
    // MARK: - body
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $exploreViewModel.searchText)
                    .padding()
                ScrollView {
                    LazyVStack {
                        ForEach(exploreViewModel.searchableUser) {user in
                            NavigationLink {
                                ProfileView(user: user)
                            } label: {
                                UserRowView(user: user)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
