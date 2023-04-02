//
//  FeedViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 26/01/2023.
//

import Firebase
import FirebaseFirestoreSwift

class FeedViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        PostService.fetchPosts { posts in
            self.posts = posts
        }
    }
}
