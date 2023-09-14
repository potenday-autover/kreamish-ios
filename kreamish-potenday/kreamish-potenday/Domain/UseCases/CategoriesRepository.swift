
import Combine
import Foundation

protocol CategoriesRepository {
    func fetchCategoryList(completion: @escaping (Result<[Category], Error>) -> Void) -> Cancellable?
}
