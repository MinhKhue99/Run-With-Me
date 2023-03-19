//
//  NotificationView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import SwiftUI

struct NotificationView: View {
    // MARK: - property
    @ObservedObject private var notificationViewModel = NotificationViewModel()
    var body: some View {
        VStack {
            Text("NotificationView")
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
