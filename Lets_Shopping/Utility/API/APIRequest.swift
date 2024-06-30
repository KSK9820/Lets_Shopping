//
//  APIRequest.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

enum APIRequest {
    case naverShopping(NaverShoppingRequest)
}

extension APIRequest {
  
    var scheme: String {
        switch self {
        case .naverShopping:
            return "https://"
        }
    }
    
    var path: [String] {
        switch self {
        case .naverShopping:
            return ["/v1","search","shop.json"]
        }
    }
    
    var queryItem: [URLQueryItem]? {
        switch self {
        case .naverShopping(let parameter):
            return parameter.toQueryItems()
        }
    }
    
    var header: [String: String]? {
        guard let clientId = Bundle.main.naverClientID,
        let clientSecret = Bundle.main.NaverClientSecret else { return nil }
        
        return [
            "X-Naver-Client-Id" : clientId,
            "X-Naver-Client-Secret" : clientSecret
        ]
    }
    
    var httpMethod: HTTPMehtod {
        switch self {
        case .naverShopping:
            return .get
        }
    }
    
    func makeURLString() -> String? {
        switch self {
        case .naverShopping:
            if let hostURL = Bundle.main.naverBaseURL {
                return scheme + hostURL + path.joined(separator: "/")
            }
            return nil
        }
    }
}


