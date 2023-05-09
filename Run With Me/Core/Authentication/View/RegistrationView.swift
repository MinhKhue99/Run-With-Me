//
//  RegistrationView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/01/2023.
//

import SwiftUI

struct RegistrationView: View {

    // MARK: - property
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var fullName: String = ""
    @State private var userName: String = ""
    @State private var errorMessage: String = ""
    @State private var isShowAlert: Bool = false
    @State private var alertTitle: String = "Oh No 🥹"
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // MARK: - function
    
    private func errorCheck() -> String? {
        if ( email.trimmingCharacters(in: .whitespaces).isEmpty ||
             password.trimmingCharacters(in: .whitespaces).isEmpty ||
             fullName.trimmingCharacters(in: .whitespaces).isEmpty ||
             userName.trimmingCharacters(in: .whitespaces).isEmpty ||
             confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty) {
            return "Please fill in all field"
        }
        
        if password.trimmingCharacters(in: .whitespaces) != confirmPassword.trimmingCharacters(in: .whitespaces) {
            return "Password not match"
        }
        
        return nil
    }
    
    private func clear() {
        self.fullName = ""
        self.userName = ""
        self.password = ""
        self.email = ""
        self.confirmPassword = ""
    }
    
    private func register() {
        if let error = errorCheck() {
            self.errorMessage = error
            isShowAlert = true
            return
        }
        authViewModel.register(
            withEmail: email,
            username: userName,
            fullname: fullName,
            password: password) { error in
            self.errorMessage = error
            isShowAlert = true
            self.clear()
            return
        }
        
    }

    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack {
                    // MARK: - header
                AuthHeaderView(mainTitle: "Get Started.", subTitle: "Create a new account")

                VStack(spacing: 40) {
                    
                    InputTextField(imageName: "person", placeholderText: "Full name", text: $fullName)
                        .textContentType(.name)
                    InputTextField(imageName: "person", placeholderText: "Username", text: $userName)
                    InputTextField(imageName: "envelope", placeholderText: "Email", text: $email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    InputTextField(imageName: "lock", placeholderText: "Password",isSecureField: true ,text: $password)
                        .textContentType(.password)
                    InputTextField(imageName: "lock", placeholderText: "Confirm Password",isSecureField: true ,text: $confirmPassword)
                        .textContentType(.password)
                }
                .padding(.horizontal, 32)
                .padding(.top, 44)

                VStack {
                    Button(action: {
                       register()
                    }, label: {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 340, height: 50)
                            .background(Color(.systemBlue))
                            .clipShape(Capsule())
                            .padding()
                    })
                    .shadow(color: .gray.opacity(0.5), radius:10, x: 0, y: 0)
                    .alert(isPresented: $isShowAlert) {
                        Alert(title: Text(alertTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .navigationDestination(isPresented: $authViewModel.isAuthenticateUser) {
                    ProfilePhotoSelectorView()
                }

                Spacer()

                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("Already have an acount?")
                            .font(.footnote)

                        Text("Login")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom, 32)
                    .foregroundColor(Color(.systemBlue))
                }

            }
            .ignoresSafeArea()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(AuthViewModel())
    }
}
