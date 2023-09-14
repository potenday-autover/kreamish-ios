
import Combine
import Foundation

protocol SubFiltersRepository {
    func fetchSubFilters(parentFilterId: Int, completion: @escaping (Result<[SubFilter], Error>) -> Void) -> Cancellable?
}

