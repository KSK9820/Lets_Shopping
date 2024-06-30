//
//  NetworkError.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/30/24.
//

import Foundation

enum NetworkError: Error {
    case wrongURLRequest
    case unknown
    case noResponse
    case outOfRangeReponse
    case emptyData
    case decoded
}
