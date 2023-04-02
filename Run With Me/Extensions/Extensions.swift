//
//  Extensions.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 29/03/2023.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
