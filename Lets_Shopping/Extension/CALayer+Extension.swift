//
//  CALayer+Extension.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import UIKit

extension CALayer {
    func addBorder(_ edges: [UIRectEdge], color: UIColor, width: CGFloat, inset: CGFloat) {
        for edge in edges {
            let border = CALayer()
            
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect(x: 0, y: 0 + inset, width: frame.width, height: width)
            case UIRectEdge.bottom:
                border.frame = CGRect(x: 0, y: frame.height - inset, width: frame.width, height: width)
            case UIRectEdge.left:
                border.frame = CGRect(x: 0 + inset, y: 0, width: width, height: frame.height)
            case UIRectEdge.right:
                border.frame = CGRect(x: frame.width - inset, y: 0, width: width, height: frame.height)
            default:
                break
            }
            
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}


