//
//  SearchResultCollectionViewCell.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell {
    
    private let itemImageView = UIImageView()
    private let likeButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(systemName: "bag"), for: .normal)
        view.tintColor = .sWhite
        view.backgroundColor = .sMediumGray.withAlphaComponent(0.5)
        view.layer.cornerRadius = 4
        
        return view
    }()
    
    private let mallNameLabel: UILabel = {
        let view = UILabel()
        
        view.font = SystemFont.regular13
        view.textColor = .sLightGray
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        
        view.font = SystemFont.regular14
        view.textColor = .sBlack
        view.numberOfLines = 2
        
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        
        view.font = SystemFont.bold16
        view.textColor = .sBlack
        
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
    
    
    // MARK: - Internal method
    
    func setContents(_ data: Item) {
        let iamgeURL = URL(string: data.image)
        itemImageView.kf.setImage(with: iamgeURL)
        mallNameLabel.text = data.mallName
        titleLabel.text = data.title
        priceLabel.text = data.lprice + "원"
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func configureLayout() {
        itemImageView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
            make.size.equalTo(itemImageView.snp.width)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(itemImageView.snp.trailing).inset(12)
            make.bottom.equalTo(itemImageView.snp.bottom).inset(12)
            make.width.equalToSuperview().dividedBy(5)
            make.height.equalTo(likeButton.snp.width)
        }
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview().offset(4)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
        }
    }
    

    
}
