//
//  ProfileImageSettingCollectionViewCell.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/15/24.
//

import UIKit

final class ProfileImageSettingCollectionViewCell: UICollectionViewCell {
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        
        view.clipsToBounds = true
        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.sLightGray.cgColor
//        view.alpha = 0.5
        view.contentMode = .scaleAspectFit
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = contentView.layer.frame.width / 2
    }
    
    
    // MARK: - internal method

    func setProfileImage(_ profile: ProfileImage) {
        profileImageView.image = UIImage(named: profile.imageName)
    }
    
    func setProfileImageBorder(status: Bool) {
        if status {
            profileImageView.layer.borderColor = UIColor.sOrange.cgColor
            profileImageView.alpha = 1

        } else {
            profileImageView.layer.borderColor = UIColor.sLightGray.cgColor
            profileImageView.alpha = 0.5
        }
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        contentView.addSubview(profileImageView)
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(contentView)
        }
    }

    
    
   
}
