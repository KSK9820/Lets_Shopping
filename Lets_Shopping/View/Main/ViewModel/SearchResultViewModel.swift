//
//  SearchResultViewModel.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

final class SearchResultViewModel {
    
    private let networkManager = NetworkManager()
    
    private(set) var filterButtonStatus = Binding<[Bool]>([true, false, false, false])
    private(set) var searchResult = Binding<SearchResultDTO?>(nil)
    private(set) var likeList = Binding<LikeItemDTO>(UserDefaults.standard.likeItem)
    
    private(set) var title: String
    private(set) var searchSort: Sort = .sim
    private(set) var startIndex = 1
    
    var totalSearchResult: String? {
        get {
            if let result = searchResult.value {
                return "\(result.total.formatted())개의 검색 결과"
            }
            return nil
        }
    }
    
    init(title: String) {
        self.title = title
    }
    
    func changeFilterButtonStatus(_ sortOption: Int) {
        var status = Array(repeating: false, count: 4)
        status[sortOption] = true
        filterButtonStatus.value = status
        searchSort = Sort.allCases[sortOption]
        startIndex = 1
        getSearchData()
    }
    
    func getSearchData() {
        networkManager.getSearchData(title, sort: searchSort, start: startIndex) { [weak self] result in
            switch result {
            case .success(let data):
                if self?.startIndex == 1 {
                    self?.searchResult.value = data
                    self?.startIndex = data.start + data.display
                } else {
                    self?.startIndex = data.start + data.display
                    self?.searchResult.value?.items.append(contentsOf: data.items)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateLikeList(_ id: String) -> Bool {
        if likeList.value.item[id] == true {
            UserDefaults.standard.likeItem.item.removeValue(forKey: id)
            likeList.value = UserDefaults.standard.likeItem
            
            return false
        } else {
            UserDefaults.standard.likeItem.item.updateValue(true, forKey: id)
            likeList.value = UserDefaults.standard.likeItem
            
            return true
        }
    }
    
    func validateLikeList(_ index: IndexPath) -> Bool {
        guard let searchResult = searchResult.value else { return false }
        let id = searchResult.items[index.row].productId
        
        if likeList.value.item[id] == true {
            return true
        } else {
            return false
        }
    }
    
}
