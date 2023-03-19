//
//  InputTextField.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/01/2023.
//

import SwiftUI

struct InputTextField: View {
    // MARK: - property
    let imageName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    @Binding var text: String

    // MARK: - body
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                if (isSecureField ?? false) {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }
            }

            Divider()
                .foregroundColor(Color(.black))
        }
    }
}

struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField(imageName: "envelope",
                       placeholderText: "Email",
                       isSecureField: false ,
                       text: .constant("")
        )
    }
}
