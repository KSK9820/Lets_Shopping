//
//  ProfileImageView.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import UIKit

final class ProfileImageView: UIView {
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.sOrange.cgColor
        view.layer.borderWidth = 3
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let cameraImageButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "camera.fill")?.withTintColor(.sWhite)
        configuration.baseBackgroundColor = .sOrange
        configuration.cornerStyle = .capsule
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .small)
        
        let view = UIButton(configuration: configuration)

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
    
    
    // MARK: - override method
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width / 2
    }
    
    
    // MARK: - Internal
    
    func setProfileImage(_ profile: ProfileImage) {
        profileImageView.image = UIImage(named: profile.imageName)
    }
    
    func hideCameraButton() {
        cameraImageButton.isHidden = true
    }
    
    
    // MARK: - ConfigureUI

    private func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(cameraImageButton)
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.edges.equalToSuperview()
        }
        cameraImageButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.size.equalTo(profileImageView.snp.width).multipliedBy(0.25)
        }
    }
    
}
