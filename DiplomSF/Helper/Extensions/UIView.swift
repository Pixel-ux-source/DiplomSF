//
//  UIview.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
