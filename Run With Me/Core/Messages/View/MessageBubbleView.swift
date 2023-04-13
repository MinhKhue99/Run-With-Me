//
//  MessageView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 09/02/2023.
//

import SwiftUI
import Firebase

struct MessageBubbleView: View {
    
    // MARK: - property
    let message: Message
    @State private var showTime = false
    
    // MARK: - body
    var body: some View {
        VStack(alignment: message.fromId == Auth.auth().currentUser?.uid ? .trailing : .leading) {
            HStack {
                Text(message.message)
                    .padding()
                    .background(message.fromId == Auth.auth().currentUser?.uid ? Color("Peach") : Color("Gray"))
                    .cornerRadius(20)
            }
            .frame(maxWidth: 300, alignment: message.fromId == Auth.auth().currentUser?.uid ? .trailing : .leading)
        }
        .frame(maxWidth: .infinity, alignment: message.fromId == Auth.auth().currentUser?.uid ? .trailing : .leading)
        .padding(.horizontal, 10)
        .onTapGesture {
            showTime.toggle()
        }
        
        if showTime {
            Text(message.timestamp.formatted(.dateTime.hour().minute()))
                .font(.caption2)
                .padding(message.fromId == Auth.auth().currentUser?.uid ? .trailing : .leading, 25)
        }
    }
}
