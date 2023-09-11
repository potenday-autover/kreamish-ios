//
//  FilterViewModel.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/09/04.
//

import Combine
import Foundation

class FilterViewModel {
    private let getProductsUseCase: GetSubFiltersUseCase
    private var subFiltersLoadTask: Cancellable?
    
    // 하드코딩.
    let filterList: [Filter] = [Filter(filterId: Constants.FILTER_CATEGORIES_ID, name: Constants.FILTER_CATEGORIES_NAME_KOR), Filter(filterId: Constants.FILTER_BRANDS_ID, name: Constants.FILTER_BRANDS_NAME_KOR), Filter(filterId: Constants.FILTER_COLLECTIONS_ID, name: Constants.FILTER_BRANDS_NAME_KOR), Filter(filterId: Constants.FILTER_SIZES_ID, name: Constants.FILTER_SIZES_NAME_KOR)]
    // 하드코딩.
    
    var selectedFilterId: Int = 0
    @Published var currentSubFilterList: [SubFilter] = []
    
    init (selectedFilterId: Int) {
        self.selectedFilterId = selectedFilterId
        // selectedFilterId에 해당하는 subFilter불러와 currentSubFilterList에 담기.
        
        // 임시 데이터 넣어둠
        currentSubFilterList = [SubFilter(subFilterId: 1, subFilterName: "신발", filterItems: [FilterItem(filterItemId: 1, filterItemName: "스니커즈"), FilterItem(filterItemId: 2, filterItemName: "구두"), FilterItem(filterItemId: 3, filterItemName: "샌들/슬리퍼"), FilterItem(filterItemId: 4, filterItemName: "부츠")]), SubFilter(subFilterId: 1, subFilterName: "신발", filterItems: [FilterItem(filterItemId: 1, filterItemName: "스니커즈"), FilterItem(filterItemId: 2, filterItemName: "구두"), FilterItem(filterItemId: 3, filterItemName: "샌들/슬리퍼"), FilterItem(filterItemId: 4, filterItemName: "부츠")]), SubFilter(subFilterId: 1, subFilterName: "신발", filterItems: [FilterItem(filterItemId: 1, filterItemName: "스니커즈"), FilterItem(filterItemId: 2, filterItemName: "구두"), FilterItem(filterItemId: 3, filterItemName: "샌들/슬리퍼"), FilterItem(filterItemId: 4, filterItemName: "부츠")]), SubFilter(subFilterId: 1, subFilterName: "신발", filterItems: [FilterItem(filterItemId: 1, filterItemName: "스니커즈"), FilterItem(filterItemId: 2, filterItemName: "구두"), FilterItem(filterItemId: 3, filterItemName: "샌들/슬리퍼"), FilterItem(filterItemId: 4, filterItemName: "부츠")])]
        // 임시 데이터 넣어둠
    }
    
    func getSubFilters() {
        load()
    }
    
    func load() {
        // subFiltersLoadTask = ...
    }
}
