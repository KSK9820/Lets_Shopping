//
//  RecentSearchKeywordTableViewCell.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import UIKit
import SnapKit

final class RecentSearchKeywordTableViewCell: UITableViewCell {
    
    private var indexPath: IndexPath?
    weak var delegate: ManipulateRecentSearchKeywordDelegate?
    
    
    private let clockImage: UIImageView = {
        let view = UIImageView()
            
        view.image = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold))
        view.tintColor = .sBlack
        
        return view
    }()
    
    private let searchKeywordLabel: UILabel = {
        let view = UILabel()
        
        view.font = SystemFont.bold15
        
        return view
    }()
    
    private lazy var deleteButton: UIButton = {
        let view = UIButton()
       
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .sBlack
        view.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 16
        view.distribution = .fillProportionally
        
        return view
    }()
    
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - internal method
    
    func setContents(_ keyword: String) {
        searchKeywordLabel.text = keyword
    }
    
    func setIndexPath(_ indexPath: IndexPath) {
        self.indexPath = indexPath
    }

    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        stackView.addArrangedSubview(clockImage)
        stackView.addArrangedSubview(searchKeywordLabel)
        stackView.addArrangedSubview(deleteButton)
        contentView.addSubview(stackView)
    }
    
    private func configureLayout() {
        clockImage.snp.makeConstraints { make in
            make.size.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.size.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
        
        stackView.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(ContentSize.searchTableViewRow.spacing)
        }
    }
    
    private func configureUI() {
        selectionStyle = .none
    }
    
    
    @objc
    private func deleteButtonTapped() {
        if let indexPath {
            delegate?.deleteRecentSearchKeyword(indexPath.row)
        }
    }

}
