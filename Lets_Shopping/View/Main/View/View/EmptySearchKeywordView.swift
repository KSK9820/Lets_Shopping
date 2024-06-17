//
//  EmptySearchKeywordView.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import UIKit

final class EmptySearchKeywordView: UIView {
    
    private let imageView = UIImageView(image: UIImage.empty)
    private let emptyLabel: UILabel = {
        let view = UILabel()
        
        view.text = "최근 검색어가 없어요"
        view.font = SystemFont.bold16
        
        return view
    }()
    
    
    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        addSubview(imageView)
        addSubview(emptyLabel)
    }
    
    private func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
}
