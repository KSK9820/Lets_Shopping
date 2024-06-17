//
//  MainViewModel.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/16/24.
//

import Foundation

final class MainViewModel {
    
    private(set) var userInformation = UserDefaults.standard.userInformation
    private(set) var recentSearchKeyword = Binding<RecentSearchKeywordDTO>(UserDefaults.standard.recentSearchKeyword)
    
    var navigationTitle: String {
        get {
            if let userInformation,
               let nickname = userInformation.nickname {
                return "\(nickname)'s Let's Shopping"
            }
            return "Let's Shopping"
        }
    }
    
    var sortedRecentKeyword: [(keyword: String, date: Date)] {
        get {
            recentSearchKeyword.value.keyword.enumerated()
                .map { ($0.element.key, $0.element.value) }
                .sorted { $0.date > $1.date }
        }
    }
    
    func existRecentKeyword() -> Bool {
        recentSearchKeyword.value.keyword == [:] ? false : true
    }
    
    func getKeyword(_ index: Int) -> String {
        sortedRecentKeyword[index].keyword
    }
    
    func addRecentSearchKeyword() {
        recentSearchKeyword.value = UserDefaults.standard.recentSearchKeyword
    }
    
    func removeRecentSearchKeyword(_ index: Int) {
        let keyword = sortedRecentKeyword[index].keyword
        
        UserDefaults.standard.recentSearchKeyword.keyword.removeValue(forKey: keyword)
        recentSearchKeyword.value = UserDefaults.standard.recentSearchKeyword
    }
    
    func removeAllRecentSearchKeyword() {
        UserDefaults.standard.recentSearchKeyword.keyword.removeAll()
        recentSearchKeyword.value = UserDefaults.standard.recentSearchKeyword
    }
    
}
