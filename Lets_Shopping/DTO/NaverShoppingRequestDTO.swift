//
//  NaverShoppingRequestDTO.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/30/24.
//

import Foundation

struct NaverShoppingRequest: Encodable {
    var display: Int
    var start: Int
    private var _sort: String
    var query: String
    
    var sort: Sort {
        get {
            return Sort(rawValue: _sort) ?? .sim
        }
        set {
            _sort = newValue.rawValue
        }
    }
    
    init(display: Int = 30, start: Int, sort: Sort = .sim, query: String) {
        self.display = display
        self.start = start
        self._sort = sort.rawValue
        self.query = query
    }
    
    enum CodingKeys: String, CodingKey {
        case display
        case start
        case sort
        case query
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(display, forKey: .display)
        try container.encode(start, forKey: .start)
        try container.encode(_sort, forKey: .sort)
        try container.encode(query, forKey: .query)
    }
    
}
