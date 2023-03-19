    //
    //  ProfileView.swift
    //  Run With Me
    //
    //  Created by Phạm Minh Khuê on 02/01/2023.
    //

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    // MARK: - property
    @State private var selectedFillter: PostFilterViewModel = .posts
    @Namespace private var animation
    @Environment(\.presentationMode) var mode
    @ObservedObject private var profileViewModel: ProfileViewModel
    
    init(user: User) {
        self.profileViewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            headerView
            actionButtons
            userInfoDetail
            postFilterBar
            postsView
            Spacer()
        }
        .toolbar(.hidden)
    }
}

extension ProfileView {
    
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Button(action: {
                    mode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: 12)
                })
                KFImage(URL(string: profileViewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)
                
            }
        }
        .frame(height: 96)
    }
    
    var actionButtons: some View {
        HStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            Button(action: {
                profileViewModel.user.isFollowed ?? false ? profileViewModel.unfollowUser() : profileViewModel.followUser()
            }, label: {
                Text(profileViewModel.actionButtonTitle)
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .foregroundColor(profileViewModel.followButtonTextColor)
            })
            .background(profileViewModel.followButtonBackgroudColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
            
        }
        .padding(.trailing)
    }
    
    var userInfoDetail: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(profileViewModel.user.fullname)
                    .font(.title2).bold()
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            
            Text("@\(profileViewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("I love you")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Hanoi, Vietnam")
                }
                
                HStack {
                    Image(systemName: "link")
                    Text("www.facbook.com")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            UserStatsView(user: profileViewModel.user)
                .padding(.vertical)
            
        }
        .padding(.leading)
    }
    
    var postFilterBar: some View {
        HStack {
            ForEach(PostFilterViewModel.allCases, id: \.rawValue) {item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFillter == item ? .semibold : .regular)
                        .foregroundColor(selectedFillter == item ? .black : .gray)
                    if (selectedFillter == item) {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "fillter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFillter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    var postsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(profileViewModel.filterPost(forFilter: self.selectedFillter)) { post in
                    PostRowView(post: post)
                }
            }
            .padding()
        }
    }
}
