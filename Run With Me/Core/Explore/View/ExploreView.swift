    //
    //  ExploreView.swift
    //  Run With Me
    //
    //  Created by Phạm Minh Khuê on 02/01/2023.
    //

import SwiftUI

struct ExploreView: View {
    
    // MARK: - property
    @ObservedObject var exploreViewModel = ExploreViewModel()
    @State private var inSearchMode = false
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView(text: $exploreViewModel.searchText, isEditing: $inSearchMode)
                    .padding()
                ScrollView {
                    if inSearchMode {
                        UserListView(exploreViewModel: exploreViewModel)
                    } else {
                        PostGridView(config: .explore)
                    }
                }
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
