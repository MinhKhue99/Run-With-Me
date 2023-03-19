//
//  NewPostView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/01/2023.
//

import SwiftUI
import Kingfisher

struct NewPostView: View {
    // MARK: - property
    @State private var caption: String = ""
    @State private var errorMessage: String = ""
    @State private var selectedImage: UIImage?
    @State private var postImage: Image?
    @State private var showImagePicker = false
    @State private var isShowAlert = false
    @State private var alertTitle = "Oh No 🥹"
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var newPostViewModel = NewPostViewModel()
    
    // MARK: - function
    
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        postImage = Image(uiImage: selectedImage)
    }
    
    func checkError() -> String? {
        if (caption.trimmingCharacters(in: .whitespaces).isEmpty) {
            return "Please write a caption or provide an image"
        }
        return nil
    }
    
    private func uploadPost() {
        if let error = checkError() {
            self.errorMessage = error
            isShowAlert = true
            return
        }
        newPostViewModel.uploadPost(withCaption: caption, withImageUrl: selectedImage!)
    }
    
    // MARK: - body
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                })

                Spacer()

                Button(action: {
                    uploadPost()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Post")
                        .bold()
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                })
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text(alertTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
            
            VStack {
                Button(action: {
                    showImagePicker.toggle()
                }, label: {
                    if let postImage = postImage {
                        postImage
                            .resizable()
                            .modifier(PostImageModifier())

                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.indigo)
                            .frame(width: 180, height: 180)
                    }
                })
                .sheet(isPresented: $showImagePicker,
                onDismiss: loadImage) {
                        // Pick an image from the photo library:
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)

                        //  If wish to take a photo from camera instead:
                        // ImagePicker(sourceType: .camera, selectedImage: self.$image)
                }
                
                
                HStack {
                    ZStack {
                        descriptionPlaceholder
                        TextEditor(text: $caption)
                            .padding()
                            .opacity(caption.isEmpty ? 0.5 : 1)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.brown))
                            .padding()
                    }
                }
                
                Divider()
            }
        }
        .onReceive(newPostViewModel.$isUploadedPost) {success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var descriptionPlaceholder: some View {
     
        HStack {
            Text("What's happening?")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                
        }
    }
}

private struct PostImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.systemBlue))
            .scaledToFill()
            .frame(width: 300, height: 180)
            .clipShape(RoundedRectangle(cornerSize: .zero))
            .shadow(color: .gray, radius: 20)
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
