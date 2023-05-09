//
//  SlideMenuViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import Foundation

enum SlideMenuViewModel: Int, CaseIterable {
    case profile
    case trackingRun
    case logout
    
    var description: String {
        switch self {
        case .profile: return "Profile"
        case .trackingRun: return "Tracking Workout"
        case .logout: return "Logout"
        }
    }
    
    var image: String {
        switch self {
        case .profile: return "person"
        case .trackingRun: return "figure.run.square.stack"
        case .logout: return "arrow.left.square"
        }
    }
}
