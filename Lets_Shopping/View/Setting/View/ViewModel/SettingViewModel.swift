//
//  SettingViewModel.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/18/24.
//

import Foundation

final class SettingViewModel {
    
    private let userDefaultManager = UserDefaultsManager.shared
    
    private(set) var profile: Binding<UserInformationDTO?>
    let likeItem: Binding<Int>
    
    let settingList = ["나의 장바구니 목록", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    init() {
        self.profile = Binding(userDefaultManager.userInformation)
        self.likeItem = Binding(userDefaultManager.likeItem.item.count)
    }
    
    func updateSetting() {
        profile.value = userDefaultManager.userInformation
        likeItem.value = userDefaultManager.likeItem.item.count
    }
    
    func deleteAllUserInformation() {
        userDefaultManager.userInformation = nil
        userDefaultManager.likeItem.item.removeAll()
        userDefaultManager.recentSearchKeyword.keyword.removeAll()
        
    }
    
}
