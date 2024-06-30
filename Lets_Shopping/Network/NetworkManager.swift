//
//  NetworkManager.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

final class NetworkManager {
    
    func dataTask(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let retryHandler = NetworkRetryHandler()
        var request = request
        request.timeoutInterval = 2.0
        
        func makeRequest() {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    if retryHandler.shouldRetry(for: error) {
                        retryHandler.incrementRetryCount()
                        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                            makeRequest()
                        }
                    } else {
                        completion(.failure(.unknown))
                    }
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    return completion(.failure(.noResponse))
                }
                
                if !(200..<300).contains(response.statusCode) {
                    completion(.failure(.outOfRangeReponse))
                }
                
                guard let data = data else {
                    return completion(.failure(.emptyData))
                }
                completion(.success(data))
            }.resume()
        }
        
        makeRequest()
    }
    
}
