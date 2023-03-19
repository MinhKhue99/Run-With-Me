//
//  Message.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 07/02/2023.
//

import Firebase
import FirebaseFirestoreSwift

struct Message: Codable, Identifiable {
    @DocumentID var id: String?
    let fromId: String
    let toId: String
    let message: String
    let timestamp: Date
}
