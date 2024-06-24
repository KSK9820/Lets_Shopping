//
//  NetworkManager.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    private init() {}
    
    
    static func getSearchData(_ keyword: String, sort: Sort = .sim, start: Int, completion: @escaping (Result<SearchResultDTO, Error>) -> Void) {
        guard let url = APIRequest.naverShopping.makeURLString() else { return }
        guard let clientId = Bundle.main.naverClientID,
              let clientSecret = Bundle.main.NaverClientSecret else { return }
        
        let header: HTTPHeaders = ["X-Naver-Client-Id" : clientId,
                                   "X-Naver-Client-Secret" : clientSecret]
        let parameter: Parameters = [
            "display" : 30,
            "start": start,
            "sort": sort.rawValue,
            "query": keyword
        ] as [String : Any]
        
        AF.request(url,
                   method: .get,
                   parameters: parameter,
                   encoding: URLEncoding.queryString,
                   headers: header
        ).responseDecodable(of: SearchResultDTO.self) { response in
            switch response.result {
            case .success(let data): 
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
