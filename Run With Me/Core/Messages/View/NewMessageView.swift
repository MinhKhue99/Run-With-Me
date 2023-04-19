//
//  NewMessageView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/02/2023.
//

import SwiftUI
import Kingfisher

struct NewMessageView: View {
    // MARK: - property
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var newMessageViewModel = NewMessageViewModel()
    let didSelectedNewUser: (User) -> ()
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(newMessageViewModel.users) { user in
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        didSelectedNewUser(user)
                    }, label: {
                        HStack(spacing: 16) {
                            KFImage(URL(string: user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(.label), lineWidth: 0.75))
                                .shadow(radius: 5)
                                .frame(width: 55, height: 55)
                            
                            Text(user.fullname)
                                .font(.headline)
                                .foregroundColor(Color("Black"))
                            Spacer()
                        }
                        .padding(.horizontal)
                        Divider()
                            .padding(.vertical, 8)
                    })
                }
            }.navigationTitle("New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(Color("Black"))
                        })
                    }
                }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
       // NewMessageView()
        MessagesView()
    }
}
