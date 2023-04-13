//
//  TitleRowView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/04/2023.
//

import SwiftUI
import Kingfisher

struct TitleRowView: View {
    @Environment(\.dismiss) private var dismiss
    let user: User?
    var body: some View {
        HStack(spacing: 10) {
            Button {
                dismiss()
                
            } label: {
                HStack {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                }
            }
            KFImage(URL(string: user?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user?.username ?? "")
                    .font(.title2)
                    .bold()
                
                Text("online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "phone.fill")
                .foregroundColor(.gray)
                .padding(10)
                .background(.white)
                .cornerRadius(50)
        }
        .padding()
        .background(Color("Peach"))
    }
}
