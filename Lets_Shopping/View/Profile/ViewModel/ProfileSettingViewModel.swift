//
//  ProfileSettingViewModel.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import Foundation

final class ProfileSettingViewModel {
    
    private(set) var type: Navigation
    private(set) lazy var userInformation = Binding<UserInformationDTO?>(nil)
    
    
    // MARK: - Initialize

    init(type: Navigation) {
        self.type = type
        if type == .onboarding {
            self.userInformation.value = UserInformationDTO(profileImage: getRandomImage())
        } else {
            self.userInformation.value = UserDefaults.standard.userInformation
        }
    }
    
    
    // MARK: - Internal method
    
    func getRandomImage() -> ProfileImage {
        ProfileImage.allCases.randomElement() ?? ProfileImage.profile_0
    }
    
    func validateNickName(_ nickname: String?) -> NickNameMessage {
        guard let nickname else { return NickNameMessage.inputError }
        
        if nickname.count < 2 || nickname.count > 9 {
            return NickNameMessage.lengthError
        }
       
        let specialCharacter = Set(["@", "#", "$", "%"])
        let nicknameSet = Set(nickname.map { String($0) })
      
        let commonCharacter = nicknameSet.intersection(specialCharacter)
        if commonCharacter != [] {
            return NickNameMessage.specialCharacterError(Array(commonCharacter))
        }
        
        let numberCharacter = nicknameSet.intersection(Set([Int](0...9).map { String($0) }))
        if numberCharacter != [] {
            return NickNameMessage.numberError
        }
    
        userInformation.value?.nickname = nickname
        return NickNameMessage.validNickName
    }
    
    func setUserProfileImage(_ profileImage: ProfileImage) {
        userInformation.value?.profileImage = profileImage
    }
    
    func saveUserInformation(_ nickname: String?) -> Bool {
        let result = validateNickName(nickname)
        
        switch result {
        case .validNickName:
            userInformation.value?.signinDate = createSigninDate()
            UserDefaults.standard.userInformation = userInformation.value
        default:
            return false
        }
        
        guard let _ = UserDefaults.standard.userInformation else {
            return false
        }
        
        return true
    }
    
    
    // MARK: - Private method
    
    private func createSigninDate() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy.MM.dd"
        
        return dateformatter.string(from: Date())
    }
    
}


