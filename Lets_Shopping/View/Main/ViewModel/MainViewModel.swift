//
//  MainViewModel.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/16/24.
//

import Foundation

final class MainViewModel {
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    private(set) var userInformation: Binding<UserInformationDTO>
    private(set) var recentSearchKeyword: Binding<RecentSearchKeywordDTO>
    private(set) var navigationTitle: String
    
    var sortedRecentKeyword: [(keyword: String, date: Date)] {
        get {
            recentSearchKeyword.value.keyword.enumerated()
                .map { ($0.element.key, $0.element.value) }
                .sorted { $0.date > $1.date }
        }
    }
    
    init() {
        self.userInformation = Binding(userDefaultsManager.userInformation ?? UserInformationDTO(profileImage: .profile_0))
        self.recentSearchKeyword = Binding(userDefaultsManager.recentSearchKeyword)
        self.navigationTitle = userInformation.value.nickname ?? "" + "'s Let's Shopping"
    }
    
    func existRecentKeyword() -> Bool {
        recentSearchKeyword.value.keyword == [:] ? false : true
    }
    
    func getKeyword(_ index: Int) -> String {
        sortedRecentKeyword[index].keyword
    }
    
    func addRecentSearchKeyword(_ keyword: String) {
        userDefaultsManager.recentSearchKeyword.keyword.updateValue(Date(), forKey: keyword)
        recentSearchKeyword.value = userDefaultsManager.recentSearchKeyword
    }
    
    func removeRecentSearchKeyword(_ index: Int) {
        let keyword = sortedRecentKeyword[index].keyword
        
        userDefaultsManager.recentSearchKeyword.keyword.removeValue(forKey: keyword)
        recentSearchKeyword.value = userDefaultsManager.recentSearchKeyword
    }
    
    func removeAllRecentSearchKeyword() {
        userDefaultsManager.recentSearchKeyword.keyword.removeAll()
        recentSearchKeyword.value = userDefaultsManager.recentSearchKeyword
    }
    
}
