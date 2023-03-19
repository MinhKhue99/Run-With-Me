//
//  ContentView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 18/12/2022.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    // MARK: - property
    @State private var isShowingMenu: Bool = false
    @EnvironmentObject var viewModel: AuthViewModel

    // MARK: - body
    var body: some View {
        Group {
            if(viewModel.userSession == nil) {
                //no user logged
                LoginView()
            } else {
                mainInterfaceView
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}

extension ContentView {
    var mainInterfaceView: some View {
        ZStack(alignment: .topLeading) {
            MainTabView()
                .toolbar(isShowingMenu ? .hidden : .visible)

            if (isShowingMenu) {
                ZStack {
                    Color(.black)
                        .opacity(isShowingMenu ? 0.25 : 0)
                }.onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isShowingMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            SlideMenuView()
                .frame(width: 300)
                .offset(x: isShowingMenu ? 0 : -300 , y: 0)
                .background(isShowingMenu ? Color.white : Color.clear)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if let user = viewModel.currentUser {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isShowingMenu.toggle()
                        }
                    }, label: {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
                            .frame(width: 32, height: 32)
                    })
                }
            }
        }
        .onAppear {
            isShowingMenu = false
        }
    }
}
