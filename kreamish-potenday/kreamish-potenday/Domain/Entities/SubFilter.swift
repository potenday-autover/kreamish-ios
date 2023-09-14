
import Foundation

struct SubFilter: Codable {
    // let filterId: Int
    let subFilterId: Int?
    let subFilterName: String
    let filterItems: [FilterItem]
}
