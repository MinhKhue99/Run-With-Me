//
//  AuthHeaderView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/01/2023.
//

import SwiftUI

struct AuthHeaderView: View {
    let mainTitle: String
    let subTitle: String
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Spacer()
            }
            Text(mainTitle)
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text(subTitle)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(RoundedShape(conrner: [.bottomRight]))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(mainTitle: "Run", subTitle: "With Me")
    }
}
