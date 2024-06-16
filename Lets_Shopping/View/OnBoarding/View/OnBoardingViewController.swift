//
//  OnBoardingStartViewController.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import UIKit
import SnapKit

final class OnBoardingStartViewController: UIViewController {
    
    private let onBoardingTitle: UILabel = {
        let view = UILabel()
        
        view.font = SystemFont.onboardingTitle
        view.textColor = .sOrange
        view.text = "Let's Shopping"
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
       
        view.image = UIImage.launch
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let startButton = OrangeButton("시작하기")

    
    // MARK: - Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureHierarchy()
        configureLayout()
    }
    
    
    
    // MARK: - Configure UI
    
    private func configureHierarchy() {
        view.addSubview(imageView)
        view.addSubview(onBoardingTitle)
        view.addSubview(startButton)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        onBoardingTitle.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.top).offset(-80)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).inset(20)
            make.centerX.equalTo(safeArea)
        }
    }
    
    
}

