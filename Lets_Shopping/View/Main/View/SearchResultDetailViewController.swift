//
//  SearchResultDetailViewController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/18/24.
//

import UIKit
import WebKit

final class SearchResultDetailViewController: UIViewController {
    
    weak var delegate: LikeDelegate?
    
    private let viewModel: SearchResultDetailViewModel
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    
    
    // MARK: - Initialize
    
    init(_ viewModel: SearchResultDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        configureHierarchy()
        configureLayout()
        configureUI()
        dataBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Data Binding
    
    private func dataBinding() {
        viewModel.likeStatus.bind { [weak self] status in
            let likeImage = UIImage(systemName: status == true ? "bag.fill" : "bag")?.withTintColor(.sBlack, renderingMode: .alwaysOriginal)
            DispatchQueue.main.async {
                self?.navigationItem.rightBarButtonItem?.image = likeImage
            }
        }
    }

    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(webView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func configureUI() {
        navigationItem.title = viewModel.detailData.title
        navigationItem.leftBarButtonItem = BlackLeftBarButtonItem(
            action: #selector(navigationBackButtonItemTapped),
            target: self)
        
        let likeImage = UIImage(systemName: viewModel.detailData.like == true ? "bag.fill" : "bag")?.withTintColor(.sBlack, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: likeImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(likeButtonTapped))
        
        if let urlRequest = viewModel.makeURLRequest() {
            webView.load(urlRequest)
        }
    }
    
    
    @objc
    private func navigationBackButtonItemTapped() {
        delegate?.updateLike(viewModel.detailData.id)
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func likeButtonTapped() {
        viewModel.updateLikeStatus()
    }
                                                            
}
