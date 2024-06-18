//
//  ManipulateRecentSearchKeywordDelegate.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

protocol ManipulateRecentSearchKeywordDelegate: AnyObject {
    func deleteRecentSearchKeyword(_ index: Int)
    func deleteAllRecentSearchKeyword()
}

