//
//  DismissCross.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 15/03/2023.
//

import SwiftUI

struct DismissCross: View {
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .font(.title2)
            .foregroundStyle(.secondary, Color(.tertiarySystemFill))
    }
}

struct DismissCross_Previews: PreviewProvider {
    static var previews: some View {
        DismissCross()
    }
}
