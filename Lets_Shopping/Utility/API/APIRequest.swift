//
//  APIRequest.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

enum APIRequest {
    case naverShopping
}

extension APIRequest {
  
    var host: String {
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
    
    func makeURLString() -> String? {
        switch self {
        case .naverShopping:
            if let baseURL = Bundle.main.naverBaseURL {
                return host + baseURL + path.joined(separator: "/")
            }
            return nil
        }
    }
}


