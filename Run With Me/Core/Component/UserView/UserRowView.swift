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
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .bold()

                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
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
            profileImageUrl: "",
            email: "test1@gmail.com")
        )
    }
}
