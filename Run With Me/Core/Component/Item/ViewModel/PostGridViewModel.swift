//
//  PostGridViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 01/04/2023.
//

import Firebase

enum PostGridConfiguration {
    case explore
    case profile(String)
}

class PostGridViewModel: ObservableObject {
    @Published var posts = [Post]()
    let config: PostGridConfiguration
    
    init(config: PostGridConfiguration) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    func fetchPosts(forConfig config: PostGridConfiguration) {
        switch config {
        case .explore:
            fetchExplorePost()
        case .profile(let uid):
            fetchProfilePost(uid: uid)
        }
    }
    
    func fetchExplorePost() {
        PostService.fetchPosts { posts in
            self.posts = posts
        }
    }
    
    func fetchProfilePost(uid: String) {
        PostService.fetchPosts(forUid: uid) {posts in
            self.posts = posts
        }
    }
}
