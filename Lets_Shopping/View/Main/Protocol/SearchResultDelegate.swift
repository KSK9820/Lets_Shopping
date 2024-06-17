//
//  SearchResultDelegate.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

protocol SearchResultDelegate: AnyObject {
    func filterButtonTapped(_ index: Int)
    func likeButtonTapped(_ index: Int) -> Bool
}
