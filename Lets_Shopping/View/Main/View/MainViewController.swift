//
//  MainViewController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/16/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    
    private let searchController: UISearchController = {
        let view = UISearchController()
        
        view.searchBar.placeholder = "브랜드, 상품 등을 입력하세요"
        view.hidesNavigationBarDuringPresentation = false
        view.automaticallyShowsCancelButton = false
        
        return view
    }()
    
    private let emptyView = EmptySearchKeywordView()
    private let keywordTableView = UITableView()
    private let headerView = RecentSearchKeywordHeaderView()
    
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
        viewModel.recentSearchKeyword.bind { [weak self] recentSearchKeyword in
            if recentSearchKeyword.keyword.count == 0 {
                DispatchQueue.main.async {
                    self?.keywordTableView.isHidden = true
                    self?.headerView.isHidden = true
                    self?.emptyView.isHidden = false
                }
            } else {
                DispatchQueue.main.async {
                    self?.keywordTableView.isHidden = false
                    self?.headerView.isHidden = false
                    self?.keywordTableView.reloadData()
                    self?.emptyView.isHidden = true
                }
            }
        }
    }
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(emptyView)
        view.addSubview(headerView)
        view.addSubview(keywordTableView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeArea)
            make.directionalHorizontalEdges.equalTo(safeArea)
            make.height.equalTo(ContentSize.searchTableViewRow.height)
        }
        
        keywordTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalTo(safeArea)
        }
    }
   
    private func configureUI() {
        navigationItem.title = viewModel.navigationTitle
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
        
        headerView.delegate = self
        
        keywordTableView.dataSource = self
        keywordTableView.delegate = self
        keywordTableView.register(RecentSearchKeywordTableViewCell.self, forCellReuseIdentifier: RecentSearchKeywordTableViewCell.reuseIdentifier)
        
        keywordTableView.separatorStyle = .none
    }
    
}


extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        
        UserDefaults.standard.recentSearchKeyword.keyword.updateValue(Date(), forKey: keyword)
        viewModel.addRecentSearchKeyword()
        navigationController?.pushViewController(SearchResultViewController(), animated: false)
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortedRecentKeyword.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchKeywordTableViewCell.reuseIdentifier, for: indexPath) as? RecentSearchKeywordTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setContents(viewModel.getKeyword(indexPath.row))
        cell.setIndexPath(indexPath)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ContentSize.searchTableViewRow.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SearchResultViewController()
        
        navigationController?.pushViewController(vc, animated: false)
    }
    
}


extension MainViewController: ManipulateRecentSearchKeywordDelegate{
    
    func deleteRecentSearchKeyword(_ index: Int)  {
        viewModel.removeRecentSearchKeyword(index)
    }
    
    func deleteAllRecentSearchKeyword() {
        viewModel.removeAllRecentSearchKeyword()
    }
    
}
