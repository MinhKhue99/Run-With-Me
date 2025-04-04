//
//  SearchBarView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 25/01/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(.gray))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .onTapGesture {
                    isEditing = true
                }
            if isEditing {
                Button(action: {
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color("Black"))
                })
                .padding(.trailing, 8)
                .transition(.move(edge: .trailing))
                .animation(.default, value: UUID())
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""), isEditing: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
