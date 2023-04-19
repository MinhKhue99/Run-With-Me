//
//  ResetPasswordView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 30/03/2023.
//

import SwiftUI
import AlertToast

struct ResetPasswordView: View {
    // MARK: - property
    @Binding private var email: String
    @State private var showToast = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    init(email: Binding<String>) {
        self._email = email
    }
    
    // MARK: - body
    var body: some View {
        VStack {
            // MARK: - header
            AuthHeaderView(mainTitle: "Run", subTitle: "With Me")
            
            Text("Reset Password")
                .font(.system(size: 30, weight: .semibold))
            
            VStack(alignment: .trailing){
                Text("enter the email addsociated with your account\nand we'll send an email with instructions to\nreset your password")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            VStack(spacing: 10) {
                InputTextField(imageName: "envelope", placeholderText: "Email", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            Button(action: {
                authViewModel.resetPassword(withEmail: email)
                showToast.toggle()
            }, label: {
                Text("Send Instructions")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            })
            
            Spacer()
            
            NavigationLink {
                LoginView()
                    .toolbar(.hidden)
            } label: {
                HStack {
                    Text("Remember password?")
                        .font(.footnote)
                        .foregroundColor(.black)
                    
                    Text("Sign in")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(.systemBlue))
            }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .alert,
                       type: .complete(.green),
            title: "Reset Password",
            subTitle: "successful sent link")
        }
        .ignoresSafeArea()
        .toolbar(.hidden)
    }
}
