//
//  Row.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 15/03/2023.
//

import SwiftUI

struct Row<Leading: View, Trailing: View>: View {
    let leading: () -> Leading
    let trailing: () -> Trailing
    
    var body: some View {
        HStack {
            leading()
            Spacer()
            trailing()
        }
    }
}
