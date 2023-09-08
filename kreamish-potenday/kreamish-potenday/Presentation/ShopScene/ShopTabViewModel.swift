
import Combine
import Foundation

class ShopTabViewModel {
    private let getCategoriesUseCase: GetCategoriesUseCase
    private var categoriesLoadTask: Cancellable?
    @Published var categoryList: [Category] = []
    
    init(getCategoriesUseCase: GetCategoriesUseCase){
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func getCategoryList() {
        load()
    }
    
    private func load() {
        categoriesLoadTask = getCategoriesUseCase.execute { result in
            switch result {
            case .success(let categoryList):
                self.categoryList = categoryList
            case .failure(let error):
                self.categoryList = [
                    Category(categoryId: 0, name: "신발"),
                    Category(categoryId: 1, name: "상의"),
                    Category(categoryId: 2, name: "하의"),
                    Category(categoryId: 3, name: "아우터")
                ]
                print(error)
            }
        }
    }
}
