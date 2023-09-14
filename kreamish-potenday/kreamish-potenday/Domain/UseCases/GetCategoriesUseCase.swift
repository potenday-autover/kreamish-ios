
import Combine
import Foundation

protocol GetCategoriesUseCase {
    func execute(completion: @escaping (Result<[Category], Error>) -> Void) -> Cancellable?
}

final class DefaultGetCategoriesUseCase: GetCategoriesUseCase {
    private let categoriesRepository: CategoriesRepository
    init(categoriesRepository: CategoriesRepository){
        self.categoriesRepository = categoriesRepository
    }
    func execute(completion: @escaping (Result<[Category], Error>) -> Void) -> Cancellable? {
        return categoriesRepository.fetchCategoryList(completion: { result in
            completion(result)
        })
    }
}
