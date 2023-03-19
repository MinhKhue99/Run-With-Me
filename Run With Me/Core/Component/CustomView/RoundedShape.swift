//
//  RoundedShape.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 04/01/2023.
//

import SwiftUI

struct RoundedShape: Shape {
    var conrner: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: conrner, cornerRadii: CGSize(width: 80, height: 80))
        return Path(path.cgPath)
    }
}
