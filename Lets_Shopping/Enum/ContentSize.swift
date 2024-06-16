//
//  ContentSize.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import UIKit

enum ContentSize {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    case orangeButton
    case nicknameTextField
    case profileImageCollectionView
    
    var spacing: CGFloat {
        switch self {
        case .orangeButton, .nicknameTextField:
            30
        case .profileImageCollectionView:
            20
        }
    }
    
    var height: CGFloat {
        switch self {
        case .orangeButton:
            50
        default:
            0
        }
    }
}
