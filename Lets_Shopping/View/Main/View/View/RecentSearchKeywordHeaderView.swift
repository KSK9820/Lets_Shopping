//
//  RecentSearchKeywordHeaderView.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import UIKit
import SnapKit

final class RecentSearchKeywordHeaderView: UIView {
    
    weak var delegate: ManipulateRecentSearchKeywordDelegate?
    
    private let label: UILabel = {
        let view = UILabel()
        
        view.text = "최근 검색"
        view.font = SystemFont.heavy16
        
        return view
    }()
    
    private lazy var deleteButton: UIButton = {
        let view = UIButton()
        
        view.setTitle("전체 삭제", for: .normal)
        view.setTitleColor(.sOrange, for: .normal)
        view.titleLabel?.font = SystemFont.regular14
        view.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
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
        addSubview(label)
        addSubview(deleteButton)
    }
    
    private func configureLayout() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ContentSize.searchTableViewRow.spacing)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(ContentSize.searchTableViewRow.spacing)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc
    private func deleteButtonTapped() {
        delegate?.deleteAllRecentSearchKeyword()
    }
    
}
