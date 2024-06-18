//
//  SearchResultHeaderView.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import UIKit
import SnapKit

final class SerchResultHeaderView: UIView {
    
    weak var delegate: SearchResultDelegate?
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        
        view.font = SystemFont.bold14
        view.text = " "
        view.textColor = .sOrange
        
        return view
    }()
    
    private let accuracyButton = GrayButton("정확도")
    private let dateOrderButton = GrayButton("날짜순")
    private let highestPriceButton = GrayButton("가격높은순")
    private let lowestPriceButton = GrayButton("가격낮은순")
    
    private let buttonStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 4
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Internal method

    func selectButton(status: [Bool]) {
        buttonStackView.arrangedSubviews.enumerated().forEach { button in
            guard let grayButton = button.element as? GrayButton else { return }
            
            grayButton.isSelected = status[button.offset]
        }
    }
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(buttonStackView)
        [accuracyButton, dateOrderButton, highestPriceButton, lowestPriceButton].forEach { button in
            buttonStackView.addArrangedSubview(button)
        }
        
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.height.equalTo(20)
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func configureUI() {
        [accuracyButton, dateOrderButton, highestPriceButton, lowestPriceButton].enumerated().forEach { button in
            button.element.tag = button.offset
            button.element.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    

    @objc
    private func buttonTapped(_ sender: UIButton) {
        delegate?.filterButtonTapped(sender.tag)
    }
    
}



