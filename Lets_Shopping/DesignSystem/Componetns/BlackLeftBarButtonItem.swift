//
//  BlackLeftBarButtonItem.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/16/24.
//

import UIKit

final class BlackLeftBarButtonItem: UIBarButtonItem {

    init(action: Selector? = nil, target: UIViewController) {
        super.init()
        image = UIImage(systemName: "chevron.left")?.withTintColor(.sBlack, renderingMode: .alwaysOriginal)
        style = .plain
        self.target = target
        self.action = action
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

