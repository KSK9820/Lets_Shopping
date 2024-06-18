//
//  ProfileSettingViewController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import UIKit
import SnapKit

final class ProfileSettingViewController: UIViewController {
    
    private let viewModel: ProfileSettingViewModel
    
    private let profileImageView = ProfileImageView()
    private let nicknameTextField = NickNameTextField()
    private let completionButton = OrangeButton("완료")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureHierarchy()
        configureLayout()
        configureUI()
        reConfigureUI()
        configureAction()
        dataBinding()
    }
    
    
    // MARK: - Initialize

    init(_ viewModel: ProfileSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Data Binding
    
    private func dataBinding() {
        viewModel.userInformation.bind { [weak self] userInformation in
            DispatchQueue.main.async {
                if let userInformation {
                    self?.profileImageView.setProfileImage(userInformation.profileImage)
                } 
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
        
        nicknameTextField.delegate = self
        
        completionButton.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
    }
    
    private func configureAction() {
        let tapGestureRecoginzer = UITapGestureRecognizer(target: self,
                                                          action: #selector(profileImageViewTapped(_:)))
        profileImageView.addGestureRecognizer(tapGestureRecoginzer)
    }
    
    private func reConfigureUI() {
        if viewModel.type == .setting {
            completionButton.isHidden = true
            nicknameTextField.setNickName(viewModel.userInformation.value?.nickname ?? "")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(navigationSaveButtonTapped))
            navigationItem.rightBarButtonItem?.tintColor = .sBlack
        }
    }
    

    // MARK: - Configure Action

    @objc
    private func profileImageViewTapped(_ sender: UITapGestureRecognizer) {
        guard let userInformation = viewModel.userInformation.value else { return }
        
        let settingVM = ProfileImageSettingViewModel(profileImage: Binding(userInformation.profileImage))
        let settingVC = ProfileImageSettingViewController(settingVM)
        
        settingVC.delegate = self
        
        navigationController?.pushViewController(settingVC, animated: false)
    }
    
    @objc 
    private func navigationBackButtonItemTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc 
    private func completionButtonTapped() {
        if viewModel.saveUserInformation(nicknameTextField.getNickName()) {
            changeRootViewController()
        }
    }
    
    @objc
    private func navigationSaveButtonTapped() {
        if viewModel.saveUserInformation(nicknameTextField.getNickName()) {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func changeRootViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        let rootviewController = TabBarController()
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
