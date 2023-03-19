//
//  MessagesView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import SwiftUI
import Firebase
import Kingfisher

struct MessagesView: View {
    
    // MARK: - property
    @ObservedObject private var authViewModel = AuthViewModel()
    @ObservedObject private var messagesViewModel = MessagesViewModel()
    @State private var isShowNewMessageScreen = false
    @State private var isNavigateToChatLogView = false
    @State var chatUser: User?
    private var chatLogViewModel = ChatLogViewModel(chatUser: nil)
    
    // MARK: - body
    var body: some View {
            NavigationStack {
                ZStack(alignment:.bottom) {
                VStack {
                    //custom navbar
                    if let user = authViewModel.currentUser {
                        HStack(spacing: 16) {
                            KFImage(URL(string: user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(.label), lineWidth: 0.75))
                                .shadow(radius: 5)
                                .frame(width: 55, height: 55)
                            
                            VStack(alignment: .leading,spacing: 4) {
                                Text(user.fullname)
                                    .font(.system(size: 20, weight: .bold))
                                HStack {
                                    Circle()
                                        .foregroundColor(.green)
                                        .frame(width: 10, height: 10)
                                    Text("Online")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color(.lightGray))
                                }
                            }
                            Spacer()
                            Image(systemName: "phone.fill")
                        }
                        .padding()
                    }
                   
                    messageview
                    
                }
                .toolbar(.hidden)
            }
            
            buttonNewMessage
                    .padding(.bottom, 30)
            .fullScreenCover(isPresented: $isShowNewMessageScreen) {
                NewMessageView(didSelectedNewUser: {user in
                    self.chatUser = user
                    self.isNavigateToChatLogView.toggle()
                    self.chatLogViewModel.chatUser = user
                    self.chatLogViewModel.fetchMessages()
                })
            }
            .navigationDestination(isPresented: $isNavigateToChatLogView) {
                ChatLogView(chatLogViewModel: chatLogViewModel)
            }
        }
    }
}

extension MessagesView {
    var messageview: some View {
        ScrollView {
            LazyVStack {
                ForEach(messagesViewModel.recentMessages) { recentMessage in
                    VStack {
                        Button(action: {
                            let uid = Auth.auth().currentUser?.uid ==
                            recentMessage.fromId ? recentMessage.toId : recentMessage.fromId
                            
                            self.chatUser = .init(username: recentMessage.fullname, fullname: recentMessage.fullname, profileImageUrl: recentMessage.profileImageUrl, email: "")
                            self.chatLogViewModel.chatUser = self.chatUser
                            self.chatLogViewModel.fetchMessages()
                            self.isNavigateToChatLogView.toggle()
                            
                        }, label: {
                            HStack(spacing: 16) {
                                KFImage(URL(string: recentMessage.profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 48, height: 48)
                                
                                VStack(alignment: .leading) {
                                    Text(recentMessage.fullname)
                                        .font(.system(size: 16, weight: .bold))
                                    Text(recentMessage.message)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(.lightGray))
                                        .multilineTextAlignment(.leading)
                                }
                                
                                Spacer()
                                
                                Text(recentMessage.timeAgo)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                        })
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.vertical, 8)
                }
            }
        }
    }
    
    
    var buttonNewMessage: some View {
        Button(action: {
            //show new message
            isShowNewMessageScreen.toggle()
        }, label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .background(Color.blue)
            .cornerRadius(32)
            .shadow(radius: 15)
            .padding(.horizontal)
        })
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
