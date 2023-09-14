
import Combine
import Foundation

protocol ProductsRepository {
    func fetchProductsPage(categoryIds: String?, brandIds: String?, collectionIds: String?, page: Int?, size: Int?, completion: @escaping (Result<ProductsPage, Error>) -> Void) -> Cancellable?
}
