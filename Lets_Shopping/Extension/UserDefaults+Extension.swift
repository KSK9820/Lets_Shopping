//
//  UserDefaults.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/16/24.
//

import Foundation

extension UserDefaults {
    
    private enum UserDefaultsKeys: String {
        case userInformation
        case recentSearchKeyword
        case likeItem
    }
    
    var userInformation: UserInformationDTO? {
        get {
            guard let userData = UserDefaults.standard.data(forKey: UserDefaultsKeys.userInformation.rawValue) else { return nil
            }
            
            return try? JSONDecoder().decode(UserInformationDTO.self, from: userData)
        }
        
        set {
            let encodedData = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsKeys.userInformation.rawValue)
        }
    }
    
    var recentSearchKeyword: RecentSearchKeywordDTO {
        get {
            guard let userData = UserDefaults.standard.data(forKey: UserDefaultsKeys.recentSearchKeyword.rawValue) else {
                return RecentSearchKeywordDTO(keyword: [:])
            }
            
            guard let decodedData = try? JSONDecoder().decode(RecentSearchKeywordDTO.self, from: userData) else {
                return RecentSearchKeywordDTO(keyword: [:])
            }
            
            return decodedData
        }
        
        set {
            let encodedData = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsKeys.recentSearchKeyword.rawValue)
        }
    }
    
    var likeItem: LikeItemDTO {
        get {
            guard let userData = UserDefaults.standard.data(forKey: UserDefaultsKeys.likeItem.rawValue) else { 
                return LikeItemDTO(item: [:]) }
            
            guard let decodedData = try? JSONDecoder().decode(LikeItemDTO.self, from: userData) else {
                return LikeItemDTO(item: [:])
            }
            
            return decodedData
        }
        
        set {
            let encodedData = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsKeys.likeItem.rawValue)
        }
    }
}
