//
//  SettingViewController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/18/24.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    
    private let viewModel = SettingViewModel()
    
    private let profileView = ProfileView()
    private let tableView = UITableView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateSetting()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureAction()
        dataBinding()
    }
    
    
    // MARK: - Data Binding
    
    private func dataBinding() {
        viewModel.likeItem.bind { [weak self] _ in
            self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        viewModel.profile.bind { [weak self] profile in
            self?.profileView.setContent(profile)
        }
    }

    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(profileView)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        profileView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(safeArea)
            make.height.equalTo(70)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalTo(safeArea).inset(12)
            make.bottom.equalTo(safeArea)
        }
    }
    
    private func configureUI() {
        profileView.setContent(viewModel.profile.value)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
    }
    
    
    // MARK: - Configure Action
    
    private func configureAction() {
        let tapGestureRecoginzer = UITapGestureRecognizer(target: self,
                                                          action: #selector(profileViewTapped))
        profileView.addGestureRecognizer(tapGestureRecoginzer)
    }
    
    
    
    private func deleteAllUserInformation() {
        viewModel.deleteAllUserInformation()
        changeRootViewController()
    }
    
    private func changeRootViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        let rootviewController = UINavigationController(rootViewController: OnBoardingStartViewController())
        sceneDelegate?.window?.rootViewController = rootviewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc
    private func profileViewTapped() {
        let vm = ProfileSettingViewModel(type: .setting)
        let vc = ProfileSettingViewController(vm)
        
        navigationController?.pushViewController(vc, animated: false)
    }
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setContents(title: viewModel.settingList[indexPath.row], like: viewModel.likeItem.value)
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = UITableViewCell()
            
            cell.textLabel?.text = viewModel.settingList[indexPath.row]
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.settingList.count - 1 {
            makeAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화 됩니다. 탈퇴하시겠습니까?", option: "확인", completion: deleteAllUserInformation)

        }
    }
    
}
