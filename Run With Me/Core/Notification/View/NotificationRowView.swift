//
//  NotificationRowView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 29/03/2023.
//

import SwiftUI
import Kingfisher

struct NotificationRowView: View {
    
    // MARK: - property
    @State private var showPostImage = false
    @ObservedObject var viewModel: NotificationRowViewModel
    var isFollowed: Bool { return viewModel.notification.isFollowed ?? false}
    init(notificationRowViewModel: NotificationRowViewModel) {
        self.viewModel = notificationRowViewModel
    }
    
    var body: some View {
        HStack {
            if let user = viewModel.notification.user {
                NavigationLink(destination: ProfileView(user: user)) {
                    KFImage(URL(string: viewModel.notification.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text(viewModel.notification.username)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black) +
                    Text(viewModel.notification.type.notificationMessage)
                        .font(.system(size: 15))
                        .foregroundColor(.black) +
                    Text(" \(viewModel.timestampString)")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.gray))
                }
            }
            
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    NavigationLink(destination: PostRowView(postRowViewModel: PostRowViewModel(post: post))) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                    }
                }
            } else {
                Button(action: {
                    isFollowed ? viewModel.unfollowUser() : viewModel.followUser()
                }, label: {
                    Text(isFollowed ? "Following" : "Follow")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 172, height: 32)
                    .foregroundColor(isFollowed ? .black : .white)
                    .background(isFollowed ? .white : .blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                    )
                })
                .cornerRadius(3)
            }
            
        }
        .padding(.horizontal)
    }
}
