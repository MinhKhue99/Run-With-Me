//
//  NewPostViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 26/01/2023.
//

import Firebase
import SwiftUI

class NewPostViewModel: ObservableObject {
    @Published var isUploadedPost: Bool = false
    let postService = PostService()
    
    func uploadPost(withCaption caption: String, withImageUrl imageUrl: UIImage?) {
        postService.uploadPost(caption: caption, image: imageUrl) { success in
            if success {
                self.isUploadedPost = true
            } else {
                
            }
        }
    }
}
