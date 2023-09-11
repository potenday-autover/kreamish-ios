//
//  ShopContentViewModel.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/09.
//
import Combine
import Foundation

class ShopContentViewModel: ObservableObject {
    @Published var trendingKeywordList: [TrendingKeyword] = []
    @Published var productList: [Product] = []
    @Published var filterList: [Filter] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTrendingKeywordList() {
        
    }
    
    func fetchProductList() {
        
    }
    
    func fetchFilterList() {
        
    }
}
