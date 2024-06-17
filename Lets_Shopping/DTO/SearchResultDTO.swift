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
}

