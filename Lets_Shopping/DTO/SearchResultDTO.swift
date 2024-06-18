//
//  SearchResultDTO.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

struct SearchResultDTO: Decodable {
    let total: Int
    var start: Int
    var display: Int
    var items: [Item]
}

struct Item: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
    
    enum CodingKeys: CodingKey {
        case title
        case link
        case image
        case lprice
        case mallName
        case productId
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title).removeHtmlTag
        self.link = try container.decode(String.self, forKey: .link)
        self.image = try container.decode(String.self, forKey: .image)
        self.lprice = try container.decode(String.self, forKey: .lprice)
        self.mallName = try container.decode(String.self, forKey: .mallName)
        self.productId = try container.decode(String.self, forKey: .productId)
    }
}

