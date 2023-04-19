//
//  ProfileActionButtonView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 30/03/2023.
//

import SwiftUI

struct ProfileActionButtonView: View {
    
    // MARK: -  property
    @ObservedObject var profileViewModel: ProfileViewModel
    var isFollowed: Bool { return profileViewModel.user.isFollowed ?? false }
    @State var showEditProfile = false
    // MARK: - body
    var body: some View {
        
        if profileViewModel.user.isCurrentUser {
            Button(action: {
                showEditProfile.toggle()
            }, label: {
            Text("Edit Profile")
                .font(.system(size: 15, weight: .semibold))
                .frame(width: 360, height: 32)
                .foregroundColor(Color("Black"))
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.gray, lineWidth: 1)
                )
            })
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(viewModel: EditProfileViewModel(user: profileViewModel.user))
            }
        } else {
            //follow and message button
            HStack {
                Button(action: {
                    isFollowed ? profileViewModel.unfollowUser() : profileViewModel.followUser()
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
                
                Button(action: {
                
                }, label: {
                Text("Message")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 172, height: 32)
                    .foregroundColor(Color("White"))
                    .background(Color("Black"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                })
                .cornerRadius(3)
            }
        }
    }
}

