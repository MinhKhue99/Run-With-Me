//
//  PostRowView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 18/12/2022.
//

import SwiftUI
import Kingfisher
import FirebaseFirestore

struct PostRowView: View {
    
    // MARK: -  property
    @ObservedObject var postRowViewModel: PostRowViewModel
    @State var chatUser: User?
    @State private var isNavigateToChatLogView = false
    @ObservedObject private var chatLogViewModel = ChatLogViewModel(chatUser: nil)
    var didLike: Bool { return postRowViewModel.post.didLike ?? false }
    init(postRowViewModel: PostRowViewModel) {
        self.postRowViewModel = postRowViewModel
    }
    
    // MARK: - body
    var body: some View {
        VStack {
            //image + username
            if let user = postRowViewModel.post.user {
                NavigationLink(destination: ProfileView(user: user)) {
                    HStack {
                        KFImage(URL(string: postRowViewModel.post.ownerImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .overlay(Circle().stroke(Color(.label), lineWidth: 0.25))
                            .clipShape(Circle())
                        
                        Text(postRowViewModel.post.ownerUsername)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Black"))
                        
                        Spacer()
                        
                        Text(postRowViewModel.timestampString)
                            .font(.footnote)
                            .padding(.trailing, 8)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 8)
                }
            }
            
            //post image
            KFImage(URL(string: postRowViewModel.post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            //action button
            HStack(spacing: 8) {
                //like post
                Button(action: {
                    didLike ? postRowViewModel.unlikePost() : postRowViewModel.likePost()
                }, label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundColor(didLike ? .red : Color("Black"))
                        .padding(4)
                })
                
                //comment
                NavigationLink(destination: CommentView(post: postRowViewModel.post)) {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                        .foregroundColor(Color("Black"))
                        .padding(4)
                }
                
                //share
                
                ShareLink(item: postRowViewModel.post.imageUrl, preview: SharePreview("\(postRowViewModel.post.caption)", image: postRowViewModel.post.imageUrl)) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                        .foregroundColor(Color("Black"))
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            
            
            //like
            Text(postRowViewModel.post.likes < 2 ? "\(postRowViewModel.post.likes) like" : "\(postRowViewModel.post.likes) likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(Color("Black"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
            
            //caption
            if postRowViewModel.post.caption.isNotEmpty{
                HStack {
                    Text(postRowViewModel.post.ownerUsername)
                        .fontWeight(.semibold)
                    +
                    Text(" \(postRowViewModel.post.caption)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .padding(.leading, 10)
                .padding(.top, 1)
            }
            Divider()
        }
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(postRowViewModel: PostRowViewModel(post: Post(
            caption: "I'm handsome",
            timestamp: Timestamp(seconds: 1683482759, nanoseconds: 371531000),
            likes: 1000,
            imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/runwithme-39a61.appspot.com/o/post%2FF6012CA1-69EE-423B-A723-B57C3AB69ACA?alt=media&token=6deea87e-c4fc-4c30-aae1-fe19218f32a5",
            ownerId: "Z4L919rREnRVBfCOBfoNRXUz7PJ2",
            ownerImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/runwithme-39a61.appspot.com/o/profile_image%2F0FA0C686-C6DF-489C-838E-A83D470B8D54?alt=media&token=ed77d581-40de-4cd5-837e-64334378b8f8",
            ownerUsername: "Phạm Minh Khuê")))
    }
}
