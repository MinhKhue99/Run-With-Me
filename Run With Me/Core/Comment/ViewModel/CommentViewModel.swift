//
//  CommentViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 05/03/2023.
//

import Firebase

class CommentViewModel: ObservableObject {
    @Published var comment: String = ""
    @Published var comments = [Comment]()
    @Published var showLoader = false
    let commentService = CommentService()
    var post: Post
    var user: User
    
    init(post: Post, user: User) {
        self.post = post
        self.user = user
        fetchComments()
    }
    
    func uploadComment() {
        commentService.uploadComment(comment: comment, postId: post.uid, user: user) { result in
            self.showLoader = true
        }
    }
    
    func fetchComments() {
        commentService.fetchComment(forPost: post.uid) { comments in
            self.comments = comments
        }
    }
}
