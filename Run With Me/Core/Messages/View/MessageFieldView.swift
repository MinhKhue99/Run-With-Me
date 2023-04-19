//
//  MessageFieldView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 05/04/2023.
//

import SwiftUI

struct MessageFieldView: View {
    @ObservedObject var chatLogViewModel: ChatLogViewModel
    var body: some View {
        HStack {
            CustomtextField(placeholder: Text("Enter your message here"), text: $chatLogViewModel.message)
            Button(action: {
                //send message
                if chatLogViewModel.message.isNotEmpty {
                    chatLogViewModel.sendMessage()
                }
            }, label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Peach"))
                    .clipShape(Circle())
            })
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("Gray"))
        .cornerRadius(50)
        .padding()
    }
}

struct CustomtextField: View {
    var placeholder: Text
    @Binding var text: String
    var edtingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            
            TextField("", text: $text, onEditingChanged: edtingChanged, onCommit: commit)
                .foregroundColor(Color.black)
        }
    }
}
