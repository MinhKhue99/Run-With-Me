//
//  CommentRowView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 21/02/2023.
//

import SwiftUI
import Kingfisher

struct CommentRowView: View {
    // MARK: - property
    let comment: Comment
    var body: some View {
        HStack {
            KFImage(URL(string: comment.profileImageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 30, height: 30, alignment: .center)
                .shadow(color: .gray, radius: 3)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(comment.username)
                    .font(.subheadline).bold()
                Text(comment.comment)
                    .font(.caption)
            }
            
            Spacer()
            
            //time
            Text("2min ago")
                .font(.subheadline)
                .padding()
        }
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(comment: Comment(
            username: "Minh Khue",
            profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/runwithme-39a61.appspot.com/o/profile_image%2FB55A57E8-86A6-4D5D-A5EC-AB9EE7B568E4?alt=media&token=cdbe3c9a-b88e-4312-816c-56dd04a6c8f1",
            timestamp: nil,
            comment: "I love you")
        )
        .previewLayout(.sizeThatFits)
    }
}
