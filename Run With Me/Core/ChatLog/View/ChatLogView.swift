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
    @Environment(\.dismiss) private var dismiss
//    let chatUser: User?
//    init(chatUser: User?) {
//        self.chatUser = chatUser
//        self.chatLogViewModel = .init(chatUser: chatUser)
//    }
    
    
    // MARK: - body
    var body: some View {
        ZStack {
            messageView
            Text(chatLogViewModel.errorMessage)
        }
        .navigationTitle(chatLogViewModel.chatUser?.fullname ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                    
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            chatLogViewModel.firestoreListener?.remove()
        }
    }
}

extension ChatLogView {
    
    
    
    var chatBottomBar: some View {
        HStack {
            Image(systemName: "photo.on.rectangle")
                .resizable()
                .scaledToFill()
                .frame(width: 25, height: 25)
                .foregroundColor(Color(.darkGray))
            
            ZStack {
                descriptionPlaceholder
                TextEditor(text: $chatLogViewModel.message)
                    .opacity(chatLogViewModel.message.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            Button(action: {
                //send message
                if chatLogViewModel.message.isNotEmpty {
                    chatLogViewModel.sendMessage()
                }
            }, label: {
                Text("Send")
                    .foregroundColor(.white)
            })
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
        .padding(.vertical, 8)
    }
    
    var messageView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(chatLogViewModel.chatMessages) {message in
                        MessageView(message: message)
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
        .background(Color("ChatLogColor"))
        .safeAreaInset(edge: .bottom) {
            chatBottomBar
                .background(Color(.systemBackground)
                    .ignoresSafeArea())
        }

    }
    
    var descriptionPlaceholder: some View {
        HStack {
            Text("Description")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
