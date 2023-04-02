//
//  LazyView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 03/04/2023.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: some View {
        build()
    }
}
