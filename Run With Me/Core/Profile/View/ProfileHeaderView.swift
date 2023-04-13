//
//  SwiftUIView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 30/03/2023.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
    // MARK: - property
    @ObservedObject var profileViewModel: ProfileViewModel
    
    // MARK: - body
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: profileViewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)
                
                Spacer()
                
                HStack(spacing: 16) {
                    if let stats = profileViewModel.user.stats {
                        UserStatView(value: stats.posts, title: "Posts")
                        UserStatView(value: stats.followers, title: "Followers")
                        UserStatView(value: stats.followings, title: "Followings")
                    }
                }
                .padding(.trailing, 32)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(profileViewModel.user.fullname)
                        .font(.system(size: 15, weight: .semibold))
                        .padding([.leading, .top])
                    if let bio = profileViewModel.user.bio {
                        Text(bio)
                            .font(.system(size: 15))
                            .padding(.leading)
                            .padding(.top, 1)
                    }
                }
                Spacer()
                
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .padding(.trailing)
            }
            
            HStack(alignment: .center) {
                Spacer()
                
                ProfileActionButtonView(profileViewModel: profileViewModel)
                
                Spacer()
            }.padding(.top)
        }
    }
}
