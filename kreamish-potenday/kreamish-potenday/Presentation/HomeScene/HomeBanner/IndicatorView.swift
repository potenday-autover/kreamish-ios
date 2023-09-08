
import Combine
import UIKit

import SnapKit

final class IndicatorView: UIView {
    private var subscription = Set<AnyCancellable>()
    private var trackViewLeftInsetConstraint: Constraint?
    private var viewModel: HomeViewModel?
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        return view
    }()
    private lazy var trackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    convenience init(viewModel: HomeViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        self.configureUI()
        self.bindUI()
    }
}
extension IndicatorView {
    private func configureUI() {
        self.addSubview(lineView)
        self.lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(3.0)
        }
        self.lineView.addSubview(trackView)
        self.trackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.width.equalToSuperview().multipliedBy(1.0/4.0)
            self.trackViewLeftInsetConstraint = $0.left.equalToSuperview().priority(999).constraint
        }
    }
    private func bindUI() {
        guard let viewModel = self.viewModel else {return}
        viewModel.widthRatioPublisher
            .receive(on: DispatchQueue.main)
            .sink { widthRatio in
                guard let widthRatio = widthRatio else {return}
                self.trackView.snp.remakeConstraints {
                  $0.top.bottom.equalToSuperview()
                  $0.width.equalToSuperview().multipliedBy(widthRatio)
                  $0.left.greaterThanOrEqualToSuperview()
                  $0.right.lessThanOrEqualToSuperview()
                  self.trackViewLeftInsetConstraint = $0.left.equalToSuperview().priority(999).constraint
                }
            }
            .store(in: &subscription)
        viewModel.leftOffsetRatioPublisher
            .sink { leftOffsetRatio in
                guard let leftOffsetRatio = leftOffsetRatio else {return}
                self.trackViewLeftInsetConstraint?.update(inset: leftOffsetRatio * self.bounds.width)
            }
            .store(in: &subscription)
    }
}
