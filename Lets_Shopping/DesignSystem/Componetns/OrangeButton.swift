//
//  OrangeButton.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import UIKit
import SnapKit

final class OrangeButton: UIButton {
    
    init(_ title: String) {
        super.init(frame: .zero)
        
        setTitleColor(.sWhite, for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.font = SystemFont.bold15
        backgroundColor = .sOrange
        layer.cornerRadius = 25
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(ContentSize.orangeButton.height)
            make.width.equalTo(ContentSize.screenWidth - ContentSize.orangeButton.spacing * 2)
        }
    }
}
