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
        HStack(spacing: 16) {
            Image(systemName: slideMunuViewModel.image)
                .font(.headline)
                .foregroundColor(.gray)

            Text(slideMunuViewModel.description)
                .font(.subheadline)
                .foregroundColor(.black)

            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SlideMenuOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuOptionRowView(slideMunuViewModel: .profile)
    }
}
