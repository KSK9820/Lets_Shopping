//
//  Bundle+Extension.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

extension Bundle {
    
    enum Keys {
        static let NaverClientID = "NaverClientID"
        static let NaverClientSecret = "NaverClientSecret"
        static let NaverBaseURL = "NaverBaseURL"
    }
    
    var naverClientID: String? {
        guard let key = Bundle.main.object(forInfoDictionaryKey: Keys.NaverClientID) as? String
        else {
            return nil
        }
        return key
    }
    
    var NaverClientSecret: String? {
        guard let key = Bundle.main.object(forInfoDictionaryKey: Keys.NaverClientSecret) as? String
        else {
            return nil
        }
        return key
    }
    
    var naverBaseURL: String? {
        guard let key = Bundle.main.object(forInfoDictionaryKey: Keys.NaverBaseURL) as? String
        else {
            return nil
        }
        return key
    }
   
}
