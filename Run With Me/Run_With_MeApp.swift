//
//  Run_With_MeApp.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 18/12/2022.
//

import SwiftUI
import Firebase

let NAME = "RunWithMe"

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct Run_With_MeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
               ContentView()
            }
            .environmentObject(authViewModel)
        }
    }
}
