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
    let user: User
    @ObservedObject private var profileViewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.profileViewModel = ProfileViewModel(user: user)
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView(profileViewModel: profileViewModel)
                
                PostGridView(config: .profile(user.id ?? ""))
            }
            .padding(.top)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(
            username: "bebo",
            fullname: "Phạm Minh Khuê",
            profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/runwithme-39a61.appspot.com/o/profile_image%2FE598E86F-0C12-4BBA-AAF0-D85F43E84DD1?alt=media&token=9ff733f0-dac6-47de-8652-52472a4fc621",
            email: "test1@gmail.com")
        )
    }
}


