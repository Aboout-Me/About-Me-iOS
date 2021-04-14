//
//  UIView+Ext.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/04/07.
//

import UIKit

extension UIView {
    
    // MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
