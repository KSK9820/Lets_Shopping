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
    }
    
    var userInformation: UserInformationDTO? {
        get {
            guard let userData = UserDefaults.standard.data(forKey: UserDefaultsKeys.userInformation.rawValue) else { return nil }
            
            return try? JSONDecoder().decode(UserInformationDTO.self, from: userData)
        }
        
        set {
            let encodedData = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsKeys.userInformation.rawValue)
        }
    }
    
}
