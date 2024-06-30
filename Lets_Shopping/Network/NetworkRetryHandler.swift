//
//  NetworkRetryHandler.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/30/24.
//

import Foundation

final class NetworkRetryHandler {
    private let maxRetryCount: Int
    private var retryCount: Int
    
    init(maxRetryCount: Int = 3, retryCount: Int = 0) {
        self.maxRetryCount = maxRetryCount
        self.retryCount = retryCount
    }
    
    func shouldRetry(for error: Error) -> Bool {
        if retryCount < maxRetryCount {
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet, .timedOut, .networkConnectionLost:
                    return true
                default:
                    return false
                }
            }
        }
        return false
    }
    
    func incrementRetryCount() {
        retryCount += 1
    }
}
