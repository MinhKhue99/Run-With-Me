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
    let postService = PostService()
    let userService = UserService()
    @Published var count = 0
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        Logger.shared.debugPrint("fetchposts")
        self.posts.removeAll()
        postService.fetchPosts { posts in
           
            self.posts = posts
            
            for index in 0 ..< posts.count {
                let uid = posts[index].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.posts[index].user = user
                }
            }
        }
    }
}
