//
//  UIView.ext.swift
//  P2PCount
//
//  Created by Dany on 29.04.2025.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
