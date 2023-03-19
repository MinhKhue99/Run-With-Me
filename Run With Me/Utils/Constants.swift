//
//  Constants.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 14/01/2023.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")

