//
//  SearchResultViewModel.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/17/24.
//

import Foundation

final class SearchResultViewModel {
    
    private(set) var filterButtonStatus = Binding<[Bool]>([true, false, false, false])
    private(set) var searchResult = Binding<SearchResultDTO?>(nil)
    var onError: (() -> Void)?
   
    private(set) var selectedCellIndexPath: IndexPath?
    private(set) var shoppingRequestInformation: NaverShoppingRequest
    
    var totalSearchResult: String? {
        get {
            if let result = searchResult.value {
                return "\(result.total.formatted())개의 검색 결과"
            }
            return nil
        }
    }
    
    init(title: String) {
        self.shoppingRequestInformation = NaverShoppingRequest(start: 1, sort: .sim, query: title)
    }
    
    func changeFilterButtonStatus(_ sortOption: Int) {
        var status = Array(repeating: false, count: 4)
        status[sortOption] = true
        filterButtonStatus.value = status
        shoppingRequestInformation.sort = Sort.allCases[sortOption]
        shoppingRequestInformation.start = 1
        getSearchData()
    }
    
    func getSearchData() {
        ServiceManager.shared.getShoppingSearchData(shoppingRequestInformation) { [weak self] result in
            switch result {
            case .success(let data):
                if self?.shoppingRequestInformation.start == 1 {
                    self?.searchResult.value = data
                    self?.shoppingRequestInformation.start = data.start + data.display
                } else {
                    self?.shoppingRequestInformation.start = data.start + data.display
                    self?.searchResult.value?.items.append(contentsOf: data.items)
                }
            case .failure(let error):
                self?.onError?()
                print(error)
            }
        }
    }
    
    func setSelectedIndex(_ indexPath: IndexPath) {
        selectedCellIndexPath = indexPath
    }
    
    func updateLikeList(_ id: String) -> Bool {
        if UserDefaults.standard.likeItem.item[id] == true {
            UserDefaults.standard.likeItem.item.removeValue(forKey: id)
            
            return false
        } else {
            UserDefaults.standard.likeItem.item.updateValue(true, forKey: id)
           
            return true
        }
    }
    
    func validateLikeList(_ index: IndexPath) -> Bool {
        guard let searchResult = searchResult.value else { return false }
        let id = searchResult.items[index.row].productId
        
        if UserDefaults.standard.likeItem.item[id] == true {
            return true
        } else {
            return false
        }
    }
    
}
