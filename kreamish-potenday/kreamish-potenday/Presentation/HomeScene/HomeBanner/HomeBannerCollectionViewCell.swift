

import UIKit

import SnapKit

final class HomeBannerCollectionViewCell: UICollectionViewCell {
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    func setUp(_ bannerImage: UIImage) {
        self.bannerImageView.image = bannerImage
        self.configureUI()
    }
}

extension HomeBannerCollectionViewCell {
    func configureUI() {
        [
            self.bannerImageView
        ].forEach {
            self.addSubview($0)
        }
        self.bannerImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
