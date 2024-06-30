//
//  UserDefaultsManager.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/16/24.
//

import Foundation

final class UserDefaultsManager {
    
    private enum UserDefaultsKeys: String {
        case userInformation
        case recentSearchKeyword
        case likeItem
    }
    
    static let shared = UserDefaultsManager()
   
    private init() { }
    
    @UserDefault(key: UserDefaultsKeys.userInformation.rawValue, defaultValue: nil)
    var userInformation: UserInformationDTO?
    
    @UserDefault(key: UserDefaultsKeys.recentSearchKeyword.rawValue, 
                 defaultValue: RecentSearchKeywordDTO(keyword: [:]))
    var recentSearchKeyword: RecentSearchKeywordDTO

    @UserDefault(key: UserDefaultsKeys.likeItem.rawValue, defaultValue: LikeItemDTO(item: [:]))
    var likeItem: LikeItemDTO
   
}


@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return defaultValue
            }
            let decodedValue = try? JSONDecoder().decode(T.self, from: data)
            return decodedValue ?? defaultValue
        }
        set {
            let encodedData = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.setValue(encodedData, forKey: key)
        }
    }
}


