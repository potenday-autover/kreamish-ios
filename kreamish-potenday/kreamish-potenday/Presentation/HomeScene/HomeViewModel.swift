
import Combine
import Foundation

protocol HomeViewModelInput {
    func computeWidthRatio(
        _ contentSizeWidth: Double,
        _ contentInsetLeft: CGFloat,
        _ contentInsetRight: CGFloat,
        _ showingWidth: Double,
        _ numberOfData: Int
    )
}

protocol HomeViewModelOutput {
    var widthRatioPublisher: AnyPublisher<Double?, Never> { get }
    var leftOffsetRatioPublisher: AnyPublisher<Double?, Never> { get }
}

typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput

final class HomeViewModel: HomeViewModelProtocol {
    var widthRatioPublisher: AnyPublisher<Double?, Never> {
        self.$widthRatio.eraseToAnyPublisher()
    }
    var leftOffsetRatioPublisher: AnyPublisher<Double?, Never> {
        self.$leftOffsetRatio.eraseToAnyPublisher()
    }
    @Published var widthRatio: Double?
    @Published var leftOffsetRatio: Double?
}
extension HomeViewModel {
    func computeWidthRatio(
        _ contentSizeWidth: Double,
        _ contentInsetLeft: CGFloat,
        _ contentInsetRight: CGFloat,
        _ showingWidth: Double,
        _ numberOfData: Int
    ) {
        let allContentSizeWidth = contentSizeWidth + contentInsetLeft + contentInsetRight
        let widthRatio = showingWidth / (allContentSizeWidth *
                                         (CGFloat((numberOfData - 4)) / CGFloat(numberOfData)))
        self.widthRatio = widthRatio
    }
    func computeLeftOffsetRatio(
        _ contentSizeWidth: Double,
        _ contentOffsetX: Double,
        _ contentInsetLeft: CGFloat,
        _ contentInsetRight: CGFloat,
        _ numberOfData: Int
    ) {
        let leftOffset = (contentOffsetX - ((contentSizeWidth / Double(numberOfData)) * 2)) + contentInsetLeft
        let entireWidth = (contentSizeWidth * CGFloat((numberOfData - 4)) /
                           CGFloat(numberOfData)) + contentInsetLeft + contentInsetRight
        let leftOffsetRatio = leftOffset / entireWidth
        self.leftOffsetRatio = leftOffsetRatio
    }
}
