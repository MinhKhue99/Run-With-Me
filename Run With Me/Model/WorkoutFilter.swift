//
//  WorkoutFilter.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 14/03/2023.
//

import Foundation

enum WorkoutDate: String, CaseIterable {
    case thisWeek = "This Week"
    case thisMonth = "This Month"
    case thisYear = "This Year"
    
    var granularity: Calendar.Component {
        switch self {
        case .thisWeek:
            return .weekOfMonth
        case .thisMonth:
            return .month
        case .thisYear:
            return .year
        }
    }
}
