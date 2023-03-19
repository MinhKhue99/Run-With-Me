//
//  SlideMenuViewModel.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import Foundation

enum SlideMenuViewModel: Int, CaseIterable {
    case profile
    case lists
    case bookmark
    case trackingRun
    case logout

    var description: String {
        switch self {
            case .profile: return "Profile"
            case .lists: return "Lists"
            case .bookmark: return "Bookmark"
            case .trackingRun: return "Tracking Run"
            case .logout: return "Logout"
        }
    }

    var image: String {
        switch self {
            case .profile: return "person"
            case .lists: return "list.bullet"
            case .bookmark: return "bookmark"
            case .trackingRun: return "figure.run.square.stack"
            case .logout: return "arrow.left.square"
        }
    }
}
