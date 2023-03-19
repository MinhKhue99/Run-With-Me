//
//  PostFillterViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import Foundation

enum PostFilterViewModel: Int, CaseIterable{
    case posts
    case replies
    case likes

    var title: String {
        switch self {
            case .posts: return "Posts"
            case .likes: return "Likes"
            case.replies: return "Replies"
        }
    }

}
