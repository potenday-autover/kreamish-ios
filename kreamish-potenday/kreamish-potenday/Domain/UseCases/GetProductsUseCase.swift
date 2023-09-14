
import Combine
import Foundation

protocol GetProductsUseCase {
    func execute(categoryIds: String?, brandIds: String?, collectionIds: String?, page: Int?, size: Int?, completion: @escaping (Result<ProductsPage, Error>) -> Void) -> Cancellable?
}

final class DefaultGetProductsUseCase: GetProductsUseCase {
    private let productsRepository: ProductsRepository
    init(productsRepository: ProductsRepository) {   // 의존성 주입
        self.productsRepository = productsRepository
    }
    func execute(categoryIds: String?, brandIds: String?, collectionIds: String?, page: Int?, size: Int?, completion: @escaping (Result<ProductsPage, Error>) -> Void) -> Cancellable? {
        return productsRepository.fetchProductsPage(categoryIds: categoryIds, brandIds: brandIds, collectionIds: collectionIds, page: page, size: size, completion: { result in
            completion(result)
        })
    }
}
