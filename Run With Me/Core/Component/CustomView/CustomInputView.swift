//
//  CustomInputView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 28/03/2023.
//

import SwiftUI

struct CustomInputView: View {
    // MARK: - property
    @Binding var inputtext: String
    var action: () -> Void
    
    // MARK: - body
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding(.bottom, 8)
            
            HStack {
                TextField("Comment...", text: $inputtext)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: action) {
                    Text("Send")
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
        }
    }
}
