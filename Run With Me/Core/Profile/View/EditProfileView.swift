//
//  EditProfileView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 03/04/2023.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    // MARK: - property
    @State private var bioText = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @State private var showSheet = false
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EditProfileViewModel
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
    }
    var descriptionPlaceholder: some View {
        
        HStack {
            Text((viewModel.user.bio?.isEmpty ?? true ? "Add your bio" : viewModel.user.bio) ?? "")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
            
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        profileImage = Image(uiImage: selectedImage)
    }
    
    private func save() {
        if (email.trimmingCharacters(in: .whitespaces).isEmpty) {
            email = viewModel.user.email
        }
        if (bioText.trimmingCharacters(in: .whitespaces).isEmpty) {
            bioText = viewModel.user.bio ?? ""
        }
        if (fullname.trimmingCharacters(in: .whitespaces).isEmpty) {
            fullname = viewModel.user.fullname
        }
        if (username.trimmingCharacters(in: .whitespaces).isEmpty) {
            username = viewModel.user.username
        }
        
        if (selectedImage == nil) {
            let url = URL(string: viewModel.user.profileImageUrl)!
            DispatchQueue.main.async {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    selectedImage = image
                }
            }
        }
        
        viewModel.saveUserBio(bioText, email: email, username: username, fullname: fullname, image: selectedImage!)
    }
    
    // MARK: - body
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Button(action: {
                    save()
                    dismiss()
                }, label: {
                    Text("Done")
                        .bold()
                })
            }
          
            Button(action: {
                showSheet.toggle()
            }, label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .modifier(ProfileImageModifier())

                } else {
                    KFImage(URL(string: viewModel.user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .shadow(color: .gray, radius: 20)
                }
            })
            .sheet(isPresented: $showSheet,
            onDismiss: loadImage) {
                    // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)

                    //  If wish to take a photo from camera instead:
                    // ImagePicker(sourceType: .camera, selectedImage: self.$image)
            }
            
            TextField(viewModel.user.fullname, text: $fullname)
                .foregroundColor(.black)
                .font(.system(size: 25, weight: .bold))
                .frame(width: 300)
                .multilineTextAlignment(.center)
            
            TextField(viewModel.user.username, text: $username)
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .semibold))
                .frame(width: 300)
                .multilineTextAlignment(.center)
            
            InputTextField(imageName: "envelope", placeholderText: "Email", text: $email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
            
//            InputTextField(imageName: "lock", placeholderText: "Password",isSecureField: true ,text: $password)
            
            Spacer()
            
            HStack {
                ZStack {
                    descriptionPlaceholder
                    TextEditor(text: $bioText)
                        .padding()
                        .opacity(bioText.isEmpty ? 0.5 : 1)
                        .frame(width: 370, height: 200)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.brown))
                }
            }
                
             Spacer()
            
        }
        .padding(.horizontal, 10)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.systemBlue))
            .scaledToFill()
            .frame(width: 180, height: 180)
            .clipShape(Circle())
            .shadow(color: .gray, radius: 20)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(viewModel: EditProfileViewModel(user: User(
            username: "bebo",
            fullname: "Pham minh khue",
            profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/runwithme-39a61.appspot.com/o/profile_image%2FB18FF860-9814-4C76-8A18-440D8FD26006?alt=media&token=ec3fa1cc-ab10-41d8-a616-8ce3ac82a064",
            email: "test1@gmail.com",
            bio: "love"
        )))
    }
}
