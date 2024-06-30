//
//  GrayButton.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import UIKit
import SnapKit

final class GrayButton: UIButton {
    
    private var title: String
    
    private lazy var selectedConfiguration: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        
        config.title = title
        config.attributedTitle = AttributedString(title,
                                                  attributes: AttributeContainer([.font: SystemFont.regular13]))
        config.baseBackgroundColor = .sDarkGray
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        return config
    }()
    
    private lazy var unselectedConfiguration: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        
        config.title = title
        config.attributedTitle = AttributedString(title,
                                                  attributes: AttributeContainer([.font: SystemFont.regular13]))
        config.background.strokeColor = .sMediumGray
        config.background.strokeWidth = 1
        config.baseBackgroundColor = .sWhite
        config.baseForegroundColor = .sBlack
        config.cornerStyle = .capsule
        
        return config
    }()
        
    override var isSelected: Bool {
        didSet {
            updateButtonConfiguration()
        }
    }
    
    
    // MARK: - Initialize
    
    init(_ title: String) {
        self.title = title
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure UI
    
    private func updateButtonConfiguration() {
        configuration = isSelected ? selectedConfiguration : unselectedConfiguration
        
    }

}
