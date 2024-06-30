//
//  Sort.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

enum Sort: String, CaseIterable, Encodable {
    case sim
    case date
    case dsc
    case asc
    
    var index: Int {
        switch self {
        case .sim:
            0
        case .date:
            1
        case .dsc:
            2
        case .asc:
            3
        }
    }
}
