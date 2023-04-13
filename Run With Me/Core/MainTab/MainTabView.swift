//
//  MainTabView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedIndex: Int = 0
//    let user: User
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                FeedView()
                    .onTapGesture {
                        
                        self.selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(0)

                ExploreView()
                    .onTapGesture {
                        self.selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(1)

                NotificationView()
                    .onTapGesture {
                        self.selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "bell")
                    }
                    .tag(2)

                MessagesView()
                    .onTapGesture {
                        self.selectedIndex = 3
                    }
                    .tabItem {
                        Image(systemName: "envelope")
                    }
                    .tag(3)
//                ProfileView(user: user)
//                    .onTapGesture {
//                        self.selectedIndex = 4
//                        Logger.shared.debugPrint("selectedIndex: \(self.selectedIndex)")
//                    }
//                    .tabItem {
//                        Image(systemName: "person")
//                    }
//                    .tag(4)
            }
            .toolbar(.hidden)
//            .navigationTitle(tabTile)
//            .navigationBarTitleDisplayMode(.inline)
//            .accentColor(.black)
        }

    }
    
    var tabTile: String {
        switch selectedIndex {
            case 0: return "Feed"
            case 1: return "Explore"
            case 2: return "Notification"
            case 3: return "Message"
            case 4: return "Profile"
            default: return ""
        }
    }
}
