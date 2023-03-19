//
//  PostRowView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 18/12/2022.
//

import SwiftUI
import Kingfisher

struct PostRowView: View {
    // MARK: - property
    @ObservedObject private var postRowViewModel: PostRowViewModel
    @State private var animate = false
    @State private var likeAnimation = false
    private let duration: Double = 0.3
    private var animationScale: CGFloat {
        postRowViewModel.post.didLike ?? false ? 0.5 : 2.0
    }
    
    init(post: Post) {
        self.postRowViewModel = PostRowViewModel(post: post)
    }
    
    func performLikeAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
            self.likeAnimation = false
        })
    }
    // MARK: - body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: -  + post
            if let user = postRowViewModel.post.user {
                
                // MARK: - profile image + user info
                HStack {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 35, height: 35, alignment: .center)
                        .shadow(color: Color.gray, radius: 3)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline).bold()
                        
                        Text(postRowViewModel.post.timeAgo)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding(.leading, 10)
                }
                .padding(.leading)
                .padding(.top, 12)
                
                // MARK: - post caption
                Text(postRowViewModel.post.caption)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical)
                    .padding(.horizontal)
                
                ZStack(alignment: .center) {
                    KFImage(URL(string: postRowViewModel.post.imageUrl))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.size.width, height: 300, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .padding(.vertical, 12)
                        .clipped()
                        .onTapGesture(count: 2) {
                            self.likeAnimation = true
                            performLikeAnimation()
                            postRowViewModel.post.didLike ?? false ? postRowViewModel.unlikePost() : postRowViewModel.likePost()
                        }
                    
                    
                    Image(systemName: postRowViewModel.post.didLike ?? false ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        .scaleEffect(likeAnimation ? 1.0 : 0.0)
                        .opacity(likeAnimation ? 1.0 : 0.0)
                        .animation(.spring(), value: UUID())
                        .foregroundColor(postRowViewModel.post.didLike ?? false ? .red : .gray)
                }
                
                VStack(alignment: .leading) {
                    // MARK: - action button
                    HStack(spacing: 0) {
                        
                        //like post
                        Button(action: {
                            self.animate = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + self.duration, execute: {
                                self.animate = false
                                postRowViewModel.post.didLike ?? false ? postRowViewModel.unlikePost() : postRowViewModel.likePost()
                            })
                        }, label: {
                            Image(systemName: postRowViewModel.post.didLike ?? false ? "heart.fill" : "heart")
                                .frame(width: 35, height: 35, alignment: .center)
                                .foregroundColor(postRowViewModel.post.didLike ?? false ? .red : .gray)
                        })
                        
                        .scaleEffect(animate ? animationScale : 1)
                        .animation(.easeIn(duration: duration), value: UUID())
                        
                        //comment
                        NavigationLink(destination: CommentView()) {
                            Image(systemName: "message")
                                .frame(width: 35, height: 35, alignment: .center)
                        }
                        
                        
                        //send mesage
                        Button(action: {
                            //action here
                        }, label: {
                            Image(systemName: "envelope")
                                .frame(width: 35, height: 35, alignment: .center)
                        })
                        
                    }
                    .padding(.leading, 5)
                    .foregroundColor(.gray)
                    
                    if (postRowViewModel.post.likes > 0) {
                        Text("\(postRowViewModel.post.likes) likes")
                            .font(.subheadline)
                            .padding(.leading)
                            .padding(.trailing, 5)
                    }
                    
                    Text("View Comment")
                        .font(.caption)
                        .padding(.leading)
                }
            }
            Divider()
                .padding(.vertical)
        }
    }
}


//struct PostRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
