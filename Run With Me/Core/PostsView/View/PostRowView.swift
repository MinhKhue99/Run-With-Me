//
//  PostRowView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 18/12/2022.
//

import SwiftUI
import Kingfisher

struct PostRowView: View {
    
    // MARK: -  property
    @ObservedObject var postRowViewModel: PostRowViewModel
    var didLike: Bool { return postRowViewModel.post.didLike ?? false }
    init(postRowViewModel: PostRowViewModel) {
        self.postRowViewModel = postRowViewModel
    }
    
    // MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
             //user info
            HStack {
                if let user = postRowViewModel.post.user {
                    NavigationLink(destination: ProfileView(user: user)) {
                        KFImage(URL(string: postRowViewModel.post.ownerImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                        
                        Text(postRowViewModel.post.ownerUsername)
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                
                Text(postRowViewModel.timestampString)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
            }
            .padding(.horizontal, 8)
            
            //post image
            KFImage(URL(string: postRowViewModel.post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 300)
                .clipped()
            
            //action button
            HStack(spacing: 8) {
                Button(action: {
                    //like post
                    didLike ? postRowViewModel.unlikePost() : postRowViewModel.likePost()
                }, label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .foregroundColor(didLike ? .red : .black)
                        .padding(4)
                })
                
                NavigationLink(destination: CommentView(post: postRowViewModel.post)) {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding(4)
                }
                
                Button(action: {
                    //send message
                }, label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding(4)
                })
            }
            .padding(.horizontal, 8)
            
            //like
            Text(postRowViewModel.post.likes < 2 ? "\(postRowViewModel.post.likes) like" : "\(postRowViewModel.post.likes) likes")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
                .padding(.horizontal, 8)
            
            //caption
            HStack {
                Text(postRowViewModel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold))
                +
                Text(" \(postRowViewModel.post.caption)")
                    .font(.system(size: 14))
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 1)
            
            Divider()
        }
    }
}
