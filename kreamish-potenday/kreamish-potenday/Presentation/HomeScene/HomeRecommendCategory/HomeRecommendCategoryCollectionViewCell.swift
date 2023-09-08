
import UIKit

import SnapKit

final class HomeRecommendCategoryCollectionViewCell: UICollectionViewCell {
    private lazy var recommendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    func setUp(_ image: UIImage, _ text: String) {
        self.configureUI()
        self.recommendImageView.image = image
        self.titleLabel.text = text
    }
}

extension HomeRecommendCategoryCollectionViewCell {
    private func configureUI() {
        self.addSubview(self.recommendImageView)
        self.recommendImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.recommendImageView.snp.bottom).offset(7)
            $0.leading.equalTo(self.recommendImageView)
            $0.trailing.equalTo(self.recommendImageView)
        }
    }
}
