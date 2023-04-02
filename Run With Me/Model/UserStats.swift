//
//  UserStats.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 14/02/2023.
//

import Firebase

struct UserStats: Decodable {
    let followers: Int
    let followings: Int
    let posts: Int
}
