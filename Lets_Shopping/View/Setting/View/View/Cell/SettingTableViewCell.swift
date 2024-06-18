//
//  SettingTableViewCell.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/18/24.
//

import UIKit
import SnapKit

final class SettingTableViewCell: UITableViewCell {
    
    private let listTitleLabel = UILabel()
    private let stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 4
        
        return view
    }()
    
    private let bagImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(systemName: "bag.fill")?.withTintColor(.sBlack, renderingMode: .alwaysOriginal)
        
        return view
    }()
    
    private let likeLabel = UILabel()
    
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Internal method
    
    func setContents(title: String, like: Int) {
        listTitleLabel.text = title
        
        likeLabel.text = "\(like)개의 상품"
        
        guard let text = likeLabel.text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.font, value: SystemFont.bold15, range: (text as NSString).range(of: "\(like)개"))
        attributeString.addAttribute(.font, value: SystemFont.regular15, range: (text as NSString).range(of: "의 상품"))
        likeLabel.attributedText = attributeString
    }

    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(listTitleLabel)
        stackView.addArrangedSubview(bagImageView)
        stackView.addArrangedSubview(likeLabel)
        contentView.addSubview(stackView)
    }
    
    private func configureLayout() {
        listTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        bagImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
}
