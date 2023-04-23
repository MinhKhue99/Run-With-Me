//
//  MainTabView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import SwiftUI

struct MainTabView: View {
    @State var showMenu = false
    @State var currentTab = 0
    init() {
        UITabBar.appearance().isHidden = true
    }
    //offset for bot DragGesture and shwowing Menu
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    //gesture offset
    @GestureState var gestureOffset: CGFloat = 0
    var body: some View {
        let sidebarWidth = getRect().width - 90
        NavigationStack {
            HStack(spacing: 0) {
                //Slide Menu
                SlideMenuView(showMenu: $showMenu)
                //TabView
                VStack(spacing: 0) {
                    TabView(selection: $currentTab) {
                        FeedView()
                            .tag(0)
                        ExploreView()
                            .tag(1)
                        NotificationView()
                            .tag(2)
                        MessagesView()
                            .tag(3)
                    }
                    
                    //Custom Tabbar
                    VStack(spacing: 0) {
                        Divider()
                        HStack(spacing: 0) {
                            TabButton(immage: "house", tag: 0)
                            TabButton(immage: "magnifyingglass", tag: 1)
                            TabButton(immage: "bell", tag: 2)
                            TabButton(immage: "message", tag: 3)
                        }
                        .padding(.top, 15)
                    }
                }
                .frame(width: getRect().width)
                //backgroud when menu showing
                .overlay(
                    Rectangle()
                        .fill(
                            Color.primary
                                .opacity(Double((offset / sidebarWidth) / 5))
                        )
                        .ignoresSafeArea(.container, edges: .vertical)
                        .onTapGesture {
                            showMenu.toggle()
                        }
                )
            }
            .frame(width: getRect().width + sidebarWidth)
            .offset(x: -sidebarWidth / 2)
            .offset(x: offset > 0 ? offset : 0)
            //Gesture
            .gesture(
                DragGesture()
                    .updating($gestureOffset, body: {value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded(onEnd(value:))
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden)
        }
        .animation(.easeOut, value: offset == 0)
        .onChange(of: showMenu) { newValue in
            if showMenu && offset == 0 {
                offset = sidebarWidth
                lastStoredOffset = offset
            }
            
            if !showMenu && offset == sidebarWidth {
                offset = 0
                lastStoredOffset = 0
            }
        }
        .onChange(of: gestureOffset) {newValue in
            onChange()
        }
        
    }
    
    func onChange() {
        let sidebarWidth = getRect().width - 90
        offset = (gestureOffset != 0) ? (gestureOffset + lastStoredOffset < sidebarWidth ? gestureOffset + lastStoredOffset : offset) : offset
    }
    
    func onEnd(value: DragGesture.Value) {
        let sidebarWidth = getRect().width - 90
        let translation = value.translation.width
        lastStoredOffset = offset
        withAnimation {
            if translation > 0 {
                if translation > (sidebarWidth / 2) {
                    //show menu
                    offset = sidebarWidth
                    showMenu = true
                } else {
                    if offset == sidebarWidth {
                        return
                    }
                    offset = 0
                    showMenu = false
                }
            } else {
                if -translation > (sidebarWidth / 2) {
                    offset = 0
                    showMenu = false
                } else {
                    if offset == 0 || !showMenu {
                        return
                    }
                    offset = sidebarWidth
                    showMenu = true
                }
            }
        }
    }
    
    @ViewBuilder
    func TabButton(immage: String, tag: Int) -> some View {
        Button(action: {
            withAnimation{currentTab = tag}
        }, label: {
            Image(systemName: immage)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .frame(width: 22, height: 22)
                .foregroundColor(currentTab == tag ? .accentColor : .gray)
                .frame(maxWidth: .infinity)
        })
    }
}
