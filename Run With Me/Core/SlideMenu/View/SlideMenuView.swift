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
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 10) {
                    AsyncImage(url: URL(string: user.profileImageUrl)) {image in
                        image.image?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 65, height: 65)
                            .clipShape(Circle())
                    }
                    
                    Text(user.fullname)
                        .font(.title2.bold())
                    
                    Text("@\(user.username)")
                        .font(.callout)
                }
                .padding(.horizontal)
                .padding(.leading)
                .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(alignment: .leading, spacing: 45) {
                            ForEach(SlideMenuViewModel.allCases, id: \.rawValue) { item in
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
                        }
                        .padding()
                        .padding(.leading)
                        .padding(.top,45)
                    }
                }
                
                VStack(spacing: 0) {
                    Divider()
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 22, height: 22)
                        })
                        
                        Spacer()
                    }
                    .padding([.horizontal, .top], 15)
                    .foregroundColor(.primary)
                }
            }
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(width: getRect().width - 90)
            .frame(maxHeight: .infinity)
            .background(
                Color.primary
                    .opacity(0.04)
                    .ignoresSafeArea(.container, edges: .vertical)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
