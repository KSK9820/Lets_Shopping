//
//  ProfileImageSettingViewModel.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/16/24.
//

import UIKit

final class ProfileImageSettingViewModel {
    
    private(set) var selectedCell = Binding<[Bool]>(Array(repeating: false, count: ProfileImage.allCases.count))
    private(set) var profileImage: Binding<ProfileImage>
    
    
    // MARK: - Initialize

    init(profileImage: Binding<ProfileImage>) {
        self.profileImage = profileImage
        
        profileImageCellTapped(profileImage.value.rawValue)
    }
    
    
    // MARK: -  internal method
    
    func profileImageCellTapped(_ item: Int) {
        var cellStatus = Array(repeating: false, count: ProfileImage.allCases.count)
        cellStatus[item] = true
        
        selectedCell.value = cellStatus
        profileImage.value = ProfileImage.allCases[item]
    }
    
}
