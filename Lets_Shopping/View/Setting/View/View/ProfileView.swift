//
//  ProfileView.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/18/24.
//

import UIKit
import SnapKit

final class ProfileView: UIView {
    
    private let imageView = ProfileImageView()
    
    private let nicknameLabel: UILabel = {
        let view = UILabel()
        
        view.font = SystemFont.heavy16
        
        return view
    }()
    
    private let signinDateLabel: UILabel = {
        let view = UILabel()
        
        view.font = SystemFont.regular14
        view.textColor = .sLightGray
        
        return view
    }()
    
    private let pushImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(systemName: "chevron.right")?.withTintColor(.sDarkGray, renderingMode: .alwaysOriginal)
        
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
    
    func setContent(_ data: UserInformationDTO?) {
        guard let data else { return }
        
        imageView.setProfileImage(data.profileImage)
        imageView.hideCameraButton()
        
        nicknameLabel.text = data.nickname
        if let date = data.signinDate {
            signinDateLabel.text = date + "가입"
        }
    }

    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        addSubview(imageView)
        addSubview(nicknameLabel)
        addSubview(signinDateLabel)
        addSubview(pushImageView)
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalToSuperview().dividedBy(0.8)
            make.width.equalTo(imageView.snp.height)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(snp.centerY).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
        }
        signinDateLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.centerY).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
        }
        pushImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
}
