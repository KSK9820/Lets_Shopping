//
//  SearchResultViewController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import UIKit
import SnapKit

final class SearchResultViewController: UIViewController {
    
    private let viewModel: SearchResultViewModel
    
    private let headerView = SerchResultHeaderView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let indexPath = viewModel.selectedCellIndexPath {
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    

    // MARK: - Initialize
    
    init(_ viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        configureHierarchy()
        configureLayout()
        configureUI()
        dataBinding()
        
        viewModel.getSearchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Data Binding
    
    private func dataBinding() {
        viewModel.filterButtonStatus.bind { [weak self] buttonStatus in
            self?.headerView.selectButton(status: buttonStatus)
            
            DispatchQueue.main.async {
                if let value = self?.viewModel.searchResult.value {
                    if value.items.count > 0 {
                        self?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                }
            }
        }
        
        viewModel.searchResult.bind { [weak self] result in
            DispatchQueue.main.async {
                self?.headerView.setTitle(self?.viewModel.totalSearchResult)
                self?.collectionView.reloadData()
            }
        }

    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(headerView)
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        headerView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(safeArea)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalTo(safeArea).inset(ContentSize.resultCollectionView.spacing)
        }
    }
    
    private func configureUI() {
        navigationItem.title = viewModel.title
        navigationItem.leftBarButtonItem = BlackLeftBarButtonItem(
                    action: #selector(navigationBackButtonItemTapped),
                    target: self)
        
        
        headerView.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.reuseIdentifier)
        
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumInteritemSpacing = 20
        let width = ContentSize.screenWidth - layout.minimumInteritemSpacing - ContentSize.resultCollectionView.spacing * 2
        layout.itemSize = CGSize(width: width / 2 , height: (width / 2) * 1.6)
        
        return layout
    }
    
    @objc private func navigationBackButtonItemTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}


extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.startIndex - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchResultCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let item = viewModel.searchResult.value {
            cell.setContents(item.items[indexPath.row])
        }
        cell.delegate = self
        cell.setIndexPath(indexPath)
        cell.setLikeButton(viewModel.validateLikeList(indexPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let searchResult = viewModel.searchResult.value else { return }
        
        let item = searchResult.items[indexPath.row]
        
        let data = SearchResultDetailDataModel(title: item.title,
                                               like: UserDefaults.standard.likeItem.item[item.productId],
                                               id: item.productId,
                                               link: item.link)
        let vm = SearchResultDetailViewModel(data)
        let vc = SearchResultDetailViewController(vm)
        
        viewModel.setSelectedIndex(indexPath)
        
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let searchResult = viewModel.searchResult.value else { break }
            if indexPath.row == viewModel.startIndex - 4 &&
                viewModel.startIndex < searchResult.total {
                viewModel.getSearchData()
            }
        }
    }
    
}



extension SearchResultViewController: SearchResultDelegate {
    
    func filterButtonTapped(_ index: Int) {
        viewModel.changeFilterButtonStatus(index)
    }
    
    func likeButtonTapped(_ index: Int) -> Bool {
        if let searchResult = viewModel.searchResult.value {
            return viewModel.updateLikeList(searchResult.items[index].productId)
        }
        return true
    }
        
}
