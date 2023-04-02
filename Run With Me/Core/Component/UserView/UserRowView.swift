//
//  UserRowView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    // MARK: - property
    let user: User
    
    // MARK: - body
    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullname)
                    .font(.system(size: 14, weight: .semibold))
                Text(user.username)
                    .font(.system(size: 14))
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)

    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User(
            username: "bebo",
            fullname: "Phạm Minh Khuê",
            profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/runwithme-39a61.appspot.com/o/profile_image%2FE598E86F-0C12-4BBA-AAF0-D85F43E84DD1?alt=media&token=9ff733f0-dac6-47de-8652-52472a4fc621",
            email: "test1@gmail.com")
        )
    }
}
