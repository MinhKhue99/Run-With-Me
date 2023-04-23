//
//  ContentView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 18/12/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - property
    @State private var isShowingMenu: Bool = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    // MARK: - body
    var body: some View {
        Group {
            if(viewModel.userSession == nil) {
                LoginView()
            } else {
                MainTabView()
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
