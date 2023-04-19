//
//  UserStatsView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 03/01/2023.
//

import SwiftUI

struct UserStatsView: View {
    var user: User
    var body: some View {
        HStack(spacing: 24) {
            HStack(spacing: 4) {
                Text("\(user.stats?.followings ?? 0)")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color("Black"))
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            HStack(spacing: 4) {
                Text("\(user.stats?.followers ?? 0)")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color("Black"))
                Text("Followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

//struct UserStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserStatsView()
//    }
//}
