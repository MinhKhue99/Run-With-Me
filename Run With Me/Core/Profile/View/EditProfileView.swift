//
//  EditProfileView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 03/04/2023.
//

import SwiftUI

struct EditProfileView: View {
    // MARK: - property
    @State private var bioText = ""
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EditProfileViewModel
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
    }
    var descriptionPlaceholder: some View {
        
        HStack {
            Text("Add your bio")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
            
        }
    }
    
    
    // MARK: - body
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Button(action: {
                    viewModel.saveUserBio(bioText)
                    dismiss()
                }, label: {
                    Text("Done")
                        .bold()
                })
            }
            .padding()
            
            HStack {
                ZStack {
                    descriptionPlaceholder
                    TextEditor(text: $bioText)
                        .padding()
                        .opacity(bioText.isEmpty ? 0.5 : 1)
                        .frame(width: 370, height: 200)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.brown))
                        .padding()
                }
            }
            Spacer()
        }
    }
    
}

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}
