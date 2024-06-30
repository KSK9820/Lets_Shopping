//
//  Encodable+Extension.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/27/24.
//

import Foundation

extension Encodable {
    
    func toQueryItems() -> [URLQueryItem]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object) as? [String: Any] else { return nil }
    
        return dictionary.map { URLQueryItem(name: $0.key, value: "\($0.value)")}
    }
   
}
