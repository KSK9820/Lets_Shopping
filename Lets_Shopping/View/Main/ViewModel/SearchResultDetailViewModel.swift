//
//  SearchResultDetailViewModel.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/18/24.
//

import Foundation

final class SearchResultDetailViewModel {
    
    private(set) var detailData: SearchResultDetailDataModel
    private(set) lazy var likeStatus = Binding<Bool>(detailData.like ?? false)
    
    init(_ detailData: SearchResultDetailDataModel) {
        self.detailData = detailData
    }
    
    func makeURLRequest() -> URLRequest? {
        if let url = URL(string: detailData.link) {
            return URLRequest(url: url)
        }
        
        return nil
    }
    
    func updateLikeStatus() {
        if likeStatus.value == true {
            UserDefaults.standard.likeItem.item.removeValue(forKey: detailData.id)
            likeStatus.value = false
        } else {
            UserDefaults.standard.likeItem.item.updateValue(true, forKey: detailData.id)
            likeStatus.value = true
        }
    }
}
