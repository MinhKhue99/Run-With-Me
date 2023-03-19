//
//  MessageView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 09/02/2023.
//

import SwiftUI
import Firebase

struct MessageView: View {
    
    // MARK: - property
    let message: Message
    
    // MARK: - body
    var body: some View {
        VStack {
            if (message.fromId == Auth.auth().currentUser?.uid) {
                HStack {
                    
                    Spacer()
                    
                    HStack {
                        Text(message.message)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color("ChatColor"))
                    .cornerRadius(25)
                }
            } else {
                HStack {
                    HStack {
                        Text(message.message)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(25)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
