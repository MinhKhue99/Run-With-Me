//
//  LoginView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/01/2023.
//

import SwiftUI

struct LoginView: View {

        // MARK: - property
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isShowAlert: Bool = false
    @State private var alertTitle: String = "Oh No 🥹"
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // MARK: - function
    
    private func errorCheck() -> String? {
        if ( email.trimmingCharacters(in: .whitespaces).isEmpty ||
             password.trimmingCharacters(in: .whitespaces).isEmpty
        ) {
            return "Please fill in all field"
        }
        
        return nil
    }
    
    private func clear() {
        self.password = ""
        self.email = ""
    }
    
    private func login() {
        if let error = errorCheck() {
            self.errorMessage = error
            isShowAlert = true
            self.clear()
            return
        }
        authViewModel.login(withEmail: email, password: password) { error in
            self.errorMessage = error
            isShowAlert = true
            self.clear()
            return
        }
        
    }

    // MARK: - body
    var body: some View {
        VStack {

                // MARK: - header
            AuthHeaderView(mainTitle: "Hello", subTitle: "Welcome Back")

            VStack(spacing: 40) {
                InputTextField(imageName: "envelope", placeholderText: "Email", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                InputTextField(imageName: "lock", placeholderText: "Password",isSecureField: true ,text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)

            HStack {
                Spacer()
                NavigationLink {
                    Text("reset passwordview")
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.trailing, 24)
                }
            }

            Button(action: {
                login()
            }, label: {
                Text("Sign in")
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

            Spacer()

            NavigationLink {
                RegistrationView()
                    .toolbar(.hidden)
            } label: {
                HStack {
                    Text("Don't have an acount?")
                        .font(.footnote)

                    Text("Sign up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(.systemBlue))
            }


        }
        .ignoresSafeArea()
        .toolbar(.hidden)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
