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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureHierarchy()
        configureLayout()
        configureUI()
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
        profileView.setContent(viewModel.profile)
        
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setContents(title: viewModel.settingList[indexPath.row], like: viewModel.likeItem )
            
            return cell
        } else {
            let cell = UITableViewCell()
            
            cell.textLabel?.text = viewModel.settingList[indexPath.row]
            
            return cell
        }
    }
    
    
}
