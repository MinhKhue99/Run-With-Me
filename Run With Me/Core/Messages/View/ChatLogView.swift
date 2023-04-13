//
//  ChatLogView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 05/02/2023.
//

import SwiftUI
import Firebase

struct ChatLogView: View {
    // MARK: - property
    @ObservedObject var chatLogViewModel: ChatLogViewModel
    static let emptyScrollToString = "Empty"
    
    // MARK: - body
    var body: some View {
        VStack {
            VStack {
                TitleRowView(user: chatLogViewModel.chatUser)
                messageView
            }
            .background(Color("Peach"))
            
            MessageFieldView(chatLogViewModel: chatLogViewModel)
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            chatLogViewModel.firestoreListener?.remove()
        }
    }
}

extension ChatLogView {
    var messageView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(chatLogViewModel.chatMessages) {message in
                        MessageBubbleView(message: message)
                    }
                    
                    HStack {
                        Spacer()
                    }
                    .id(ChatLogView.emptyScrollToString)
                }
                .onReceive(chatLogViewModel.$count) {_ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo(ChatLogView.emptyScrollToString, anchor: .bottom)
                    }
                }
            }
        }
        .padding(.top, 10)
        .background(.white)
        .cornerRadius(30, corners: [.topLeft, .topRight])
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
