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
                .frame(width: 35, height: 35, alignment: .center)
                .shadow(color: .gray, radius: 3)
                .padding(.leading)
            
            Text(comment.username)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color("Black"))
            Text(comment.commentText)
                .font(.system(size: 15))
                .foregroundColor(Color("Black"))
            
            Spacer()
            
            //time
            Text(comment.timestampString)
                .font(.system(size: 12))
                .foregroundColor(Color("Gray"))
                .padding(.horizontal)
        }
    }
}
