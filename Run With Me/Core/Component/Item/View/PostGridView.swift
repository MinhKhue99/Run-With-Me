//
//  PostGridView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 29/03/2023.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    // MARK: - property
    @ObservedObject var postGridViewModel: PostGridViewModel
    private let item = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    let config: PostGridConfiguration
    
    init(config: PostGridConfiguration) {
        self.config = config
        postGridViewModel = PostGridViewModel(config: config)
    }
    
    // MARK: - body
    var body: some View {
        LazyVGrid(columns: item, spacing: 2 ,content: {
            ForEach(postGridViewModel.posts) { post in
                NavigationLink(destination: PostRowView(postRowViewModel: PostRowViewModel(post: post))) {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                        .cornerRadius(5, corners: [.allCorners])
                }
            }
        })
    }
}

