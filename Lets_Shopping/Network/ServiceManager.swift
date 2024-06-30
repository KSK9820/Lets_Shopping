//
//  ServiceManager.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/27/24.
//

import Foundation

final class ServiceManager {
    
    static let shared = ServiceManager()
    
    private let networkManager = NetworkManager()
    private let decoder = JSONDecoder()
    
    private init() { }
    
    private func getDecodedData<T: Decodable>(request: URLRequest, type: T.Type,
                                      completion: @escaping (Result<T, NetworkError>) -> Void) {
        networkManager.dataTask(request) { result in
            switch result {
            case .success(let data):
                guard let decodedData = try? self.decoder.decode(T.self, from: data) else {
                    return completion(.failure(.decoded))
                }
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func makeRequest(_ request: APIRequest) -> URLRequest? {

        guard let urlString = request.makeURLString() else { return nil }
        guard var components = URLComponents(string: urlString) else { return nil }
        
        if let queries = request.queryItem {
            components.queryItems = queries
        }
        
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.header
        
        return urlRequest
    }
    
    func getShoppingSearchData(_ requestDTO: NaverShoppingRequest, completion: @escaping (Result<SearchResultDTO, NetworkError>) -> Void) {
        
        guard let request = makeRequest(APIRequest.naverShopping(requestDTO)) else {
            return completion(.failure(.wrongURLRequest))
        }
        
        getDecodedData(request: request, type: SearchResultDTO.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
