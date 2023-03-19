//
//  Blur.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 15/03/2023.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
