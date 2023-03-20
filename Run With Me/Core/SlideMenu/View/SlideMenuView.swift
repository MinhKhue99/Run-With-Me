//
//  SlideMenuView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import SwiftUI
import Kingfisher

struct SlideMenuView: View {
    
    // MARK: - property
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var isShowLogoutoption = false
    
    // MARK: - body
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                
                VStack(alignment: .leading) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
                        .frame(width: 48, height: 48)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                        
                        Text("@\(user.username)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading)
                
                ForEach(SlideMenuViewModel.allCases, id: \.rawValue) {item in
                    switch item {
                    case .profile: do {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SlideMenuOptionRowView(slideMunuViewModel: item)
                        }
                    }
                    case .trackingRun: do {
                        NavigationLink {
                            TrackingRunView()
                        } label: {
                            SlideMenuOptionRowView(slideMunuViewModel: item)
                        }
                    }
                    case .logout: do {
                        Button(action: {
                            self.isShowLogoutoption.toggle()
                        }, label: {
                            SlideMenuOptionRowView(slideMunuViewModel: item)
                        })
                        .confirmationDialog("Are you sure?", isPresented: $isShowLogoutoption, titleVisibility: .visible) {
                            Button("Logout") {
                                authViewModel.logout()
                            }
                        }
                    }
                    }
                }
                
                Spacer()
            }
        }
    }
}
