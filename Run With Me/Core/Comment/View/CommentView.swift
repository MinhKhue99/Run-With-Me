//
//  CommentView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 28/02/2023.
//

import SwiftUI

struct CommentView: View {
    
    // MARK: - property
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var commentViewModel: CommentViewModel
    @State var commentText = ""
    
    init(post: Post) {
        self.commentViewModel = CommentViewModel(post: post)
    }
    
    // MARK: - body
    var body: some View {
        VStack {
            // MARK: - comment cell
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(commentViewModel.comments) { comment in
                       CommentRowView(comment: comment)
                    }
                }
            }
            // MARK: - input comment
            CustomInputView(inputtext: $commentText, action: uploadComment)
        }
        .navigationTitle("Comment")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                    
                } label: {
                    HStack(spacing: 0) {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func uploadComment() {
        commentViewModel.uploadComment(commentText: commentText)
        commentText = ""
    }
}
