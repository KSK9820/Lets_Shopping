//
//  ProfileImageSettingViewController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/15/24.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {
    
    private let viewModel: ProfileImageSettingViewModel
    
    weak var delegate: ProfileSettingDelegate?
    
    private let profileImageView = ProfileImageView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureHierarchy()
        configureLayout()
        configureUI()
        dataBinding()
    }
    
    
    // MARK: - Initialize
    
    init(_ viewModel: ProfileImageSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Data Binding
    
    private func dataBinding() {
        viewModel.selectedCell.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.profileImage.bind { [weak self] profileImage in
            DispatchQueue.main.async {
                self?.profileImageView.setProfileImage(profileImage)
            }
        }
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(40)
            make.centerX.equalTo(safeArea)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(50)
            make.directionalHorizontalEdges.equalTo(safeArea).inset(20)
            make.bottom.equalTo(safeArea)
        }
    }
    
    private func configureUI() {
        navigationItem.title = "PROFILE SETTING"
        navigationItem.leftBarButtonItem = BlackLeftBarButtonItem(
            action: #selector(navigationBackButtonItemTapped),
            target: self)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProfileImageSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageSettingCollectionViewCell.reuseIdentifier)
    }

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let width = ContentSize.screenWidth - ContentSize.profileImageCollectionView.spacing * 2 - layout.minimumInteritemSpacing * 3
        layout.itemSize = CGSize(width: width / 4, height: width / 4)
        
        return layout
    }
    
    @objc private func navigationBackButtonItemTapped() {
        delegate?.getSelectedProfile(viewModel.profileImage.value)
        navigationController?.popViewController(animated: true)
    }
    
}


extension ProfileImageSettingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ProfileImage.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageSettingCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileImageSettingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setProfileImage(ProfileImage.allCases[indexPath.row])
        cell.setProfileImageBorder(status: viewModel.selectedCell.value[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.profileImageCellTapped(indexPath.row)
    }
    
}
