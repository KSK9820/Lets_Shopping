//
//  SettingViewModel.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/18/24.
//

import Foundation

final class SettingViewModel {
    
    private(set) var profile = Binding<UserInformationDTO?>(UserDefaults.standard.userInformation)
    let likeItem = Binding<Int>(UserDefaults.standard.likeItem.item.count)
    let settingList = ["나의 장바구니 목록", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    
    func updateSetting() {
        profile.value = UserDefaults.standard.userInformation
        likeItem.value = UserDefaults.standard.likeItem.item.count
    }
}
