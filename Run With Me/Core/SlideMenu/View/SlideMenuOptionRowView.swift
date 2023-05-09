//
//  SlideMenuRowView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 02/01/2023.
//

import SwiftUI

struct SlideMenuOptionRowView: View {
    let slideMunuViewModel: SlideMenuViewModel
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: slideMunuViewModel.image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .frame(width: 22, height: 22)

            Text(slideMunuViewModel.description)
        }
        .foregroundColor(.primary)
    }
}

struct SlideMenuOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuOptionRowView(slideMunuViewModel: .profile)
    }
}
