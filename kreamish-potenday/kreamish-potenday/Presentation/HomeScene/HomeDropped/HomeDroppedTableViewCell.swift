
import UIKit

import SnapKit

final class HomeDroppedTableViewCell: UITableViewCell {
    private let images: [UIImage] = [
        UIImage(named: "Goods_1")!,
        UIImage(named: "Goods_2")!,
        UIImage(named: "Goods_3")!,
        UIImage(named: "Goods_4")!
    ]
    private let names: [String] = [
        "Jordan",
        "Nike",
        "Jordan",
        "Adidas"
    ]
    private let descriptions: [String] = [
        "Jordan 1 Retro Low OG EX White and Coconut Milk",
        "Nike x Drake Nocta NRG LR Track Jacket Dark wine (DR2618-646)",
        "Jordan 1 Retro High Spider-Man Next Chapter",
        "Adidas x BAPE Forum 84 Low Green Camo"
    ]
    private let prices: [String] = [
        "179,000원",
        "390,000원",
        "279,000원",
        "232,000원"
    ]
    private var viewModel: HomeViewModel?
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.text = DroppedText.mainTitle.rawValue
        return label
    }()
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .lightGray
        label.text = DroppedText.subTitle.rawValue
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(HomeDroppedCollectionViewCell.self,
                                forCellWithReuseIdentifier: "HomeDroppedCollectionViewCell")
        return collectionView
    }()
    func setUp(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.configureUI()
    }
}
extension HomeDroppedTableViewCell {
    private func configureUI() {
        self.contentView.addSubview(self.mainLabel)
        self.mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview()
        }
        self.contentView.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints {
            $0.top.equalTo(self.mainLabel.snp.bottom)
            $0.leading.equalTo(self.mainLabel.snp.leading)
            $0.trailing.equalTo(self.mainLabel.snp.trailing)
        }
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.subLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
extension HomeDroppedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width / 1.8, height: self.collectionView.bounds.height)
    }
}
extension HomeDroppedTableViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.images.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "HomeDroppedCollectionViewCell", for: indexPath
            ) as? HomeDroppedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUp(
            self.images[indexPath.item],
            self.names[indexPath.item],
            self.descriptions[indexPath.item],
            self.prices[indexPath.item]
        )
        return cell
    }
}
