
import Foundation

struct ProductsPage: Codable {
    let products: [Product]
    let totalElements: Int
    let totalPages: Int
    let page: Int
}
