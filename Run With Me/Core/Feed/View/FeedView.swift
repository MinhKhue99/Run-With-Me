//
//  FeedView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 18/12/2022.
//

import SwiftUI

struct FeedView: View {
    // MARK: - property
    @State private var isShowNewPostView: Bool = false
    @ObservedObject private var feedViewModel = FeedViewModel()
    @State private var isShowingMenu: Bool = false
    
    // MARK: - body
    var body: some View {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 20) {
                        ForEach(feedViewModel.posts) {post in
                            PostRowView(postRowViewModel: PostRowViewModel(post: post))
                        }
                    }
                }

                Button(action: {
                    isShowNewPostView.toggle()
                }, label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 28, height: 28)
                        .padding()
                })
                .background(Color(.black))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .fullScreenCover(isPresented: $isShowNewPostView) {
                    NewPostView()
                }
            }
            .refreshable {
                feedViewModel.fetchPosts()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
