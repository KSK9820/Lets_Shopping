//
//  ProfileSettingViewController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import UIKit
import SnapKit

final class ProfileSettingViewController: UIViewController {
    
    private let viewModel = ProfileSettingViewModel()
    
    private let profileImageView = ProfileImageView()
    private let nicknameTextField = NickNameTextField()
    private let completionButton = OrangeButton("완료")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureHierarchy()
        configureLayout()
        configureUI()
        dataBinding()
    }
    
    
    // MARK: - Data Binding
    
    private func dataBinding() {
        viewModel.userInformation.bind { [weak self] userInformation in
            DispatchQueue.main.async {
                self?.profileImageView.setProfileImage(userInformation.profileImage)
            }
        }
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(completionButton)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.top.equalTo(safeArea).offset(40)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.centerX.equalTo(safeArea)
        }
        
        completionButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.centerX.equalTo(safeArea)
        }
    }
    
    private func configureUI() {
        navigationItem.title = "PROFILE SETTING"
        navigationItem.leftBarButtonItem = BlackLeftBarButtonItem(
            action: #selector(navigationBackButtonItemTapped),
            target: self
        )
        
        let tapGestureRecoginzer = UITapGestureRecognizer(target: self,
                                                          action: #selector(profileImageViewTapped(_:)))
        profileImageView.addGestureRecognizer(tapGestureRecoginzer)
        
        nicknameTextField.delegate = self
        
        completionButton.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
    }
    

    // MARK: - Configure Action

    @objc
    private func profileImageViewTapped(_ sender: UITapGestureRecognizer) {
        let settingVM = ProfileImageSettingViewModel(profileImage: Binding(viewModel.userInformation.value.profileImage))
        let settingVC = ProfileImageSettingViewController(settingVM)
        settingVC.delegate = self
        
        navigationController?.pushViewController(settingVC, animated: false)
    }
    
    @objc private func navigationBackButtonItemTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func completionButtonTapped() {
        if viewModel.saveUserInformation() {
            changeRootViewController()
        }
    }
    
    private func changeRootViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        let rootviewController = UINavigationController(rootViewController: TabBarController())
        sceneDelegate?.window?.rootViewController = rootviewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}


extension ProfileSettingViewController: NickNameTextFieldDelegate {

    func validateTextField(_ nickname: String?) -> String {
        return viewModel.validateNickName(nickname).description
    }
    
}


extension ProfileSettingViewController: ProfileSettingDelegate {
    
    func getSelectedProfile(_ profileImage: ProfileImage) {
        viewModel.setUserProfileImage(profileImage)
    }

}
