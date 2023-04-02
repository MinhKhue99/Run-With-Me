//
//  UserStatView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 30/03/2023.
//

import SwiftUI

struct UserStatView: View {
    
    // MARK: - property
    let value: Int
    let title: String
    
    // MARK: - body
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 15, weight: .semibold))
            
            Text("\(title)")
                .font(.system(size: 15))
        }
        .frame(width: 80, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 2, title: "Follow")
    }
}
