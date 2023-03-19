//
//  ProfilePhotoSelectorView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 08/01/2023.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    // MARK: - property
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @State private var showSheet = false
    @EnvironmentObject var authViewModel: AuthViewModel

    // MARK: - body
    var body: some View {
        VStack {
            AuthHeaderView(mainTitle: "Setup Account",
                           subTitle: "Add a profile photo")

            Button(action: {
                showSheet.toggle()
            }, label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .modifier(ProfileImageModifier())

                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.indigo)
                        .frame(width: 180, height: 180)
                }
            })
            .sheet(isPresented: $showSheet,
            onDismiss: loadImage) {
                    // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)

                    //  If wish to take a photo from camera instead:
                    // ImagePicker(sourceType: .camera, selectedImage: self.$image)
            }
            .padding(.top, 40)

            if let selectedImage = selectedImage {
                Button(action: {
                    authViewModel.uploadProfileImage(selectedImage)
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                })
                .shadow(color: .gray.opacity(0.5), radius:10, x: 0, y: 0)
            }

            Spacer()
        }
        .ignoresSafeArea()

    }

    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        profileImage = Image(uiImage: selectedImage)
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

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
