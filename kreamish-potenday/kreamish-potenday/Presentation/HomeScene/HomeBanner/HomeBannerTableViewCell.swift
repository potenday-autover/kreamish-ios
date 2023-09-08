

import Combine
import UIKit

import SnapKit

final class HomeBannerTableViewCell: UITableViewCell {
    private var subscription = Set<AnyCancellable>()
    private var viewModel: HomeViewModel?
    private var imageList: [UIImage] = [
        UIImage(named: "Kream_1")!,
        UIImage(named: "Kream_2")!,
        UIImage(named: "Kream_3")!,
        UIImage(named: "Kream_4")!,
    ]
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(HomeBannerCollectionViewCell.self,
                                forCellWithReuseIdentifier: "BannerCollectionViewCell"
        )
        return collectionView
    }()
    private lazy var indicatorView: IndicatorView = {
        guard let viewModel = viewModel else {return IndicatorView()}
        let indicatorView = IndicatorView(viewModel: viewModel)
        return indicatorView
    }()
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.entryCollectionItem()
        self.bindWidthRatio(
            self.collectionView.contentSize.width,
            self.collectionView.contentInset.left,
            self.collectionView.contentInset.right,
            self.collectionView.bounds.width,
            self.imageList.count
        )
        self.bannerTimer()
    }
    func setUp(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.configureUI()
        self.imageList.insert(self.imageList[self.imageList.count - 1], at: 0)
        self.imageList.append(imageList[1])
        self.imageList.insert(self.imageList[self.imageList.count - 3], at: 0)
        self.imageList.append(imageList[3])
    }
}

extension HomeBannerTableViewCell {
    private func configureUI() {
        self.contentView.addSubview(collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        self.contentView.addSubview(indicatorView)
        self.indicatorView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(4)
        }
    }
    private func bindWidthRatio(
        _ contentSizeWidth: Double,
        _ contentInsetLeft: CGFloat,
        _ contentInsetRight: CGFloat,
        _ showingWidth: Double,
        _ numberOfData: Int
    ) {
        guard let homeViewModel = self.viewModel else {return}
        homeViewModel.computeWidthRatio(
            contentSizeWidth,
            contentInsetLeft,
            contentInsetRight,
            showingWidth,
            numberOfData
        )
        self.indicatorView.layoutIfNeeded()
    }
    private func entryCollectionItem() {
        let indexPath = IndexPath(item: 2, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
    }
    func computeCurrentIndex() -> Int{
        let visibleIndexPaths = self.collectionView.indexPathsForVisibleItems
        guard let currentVisibleIndexPath = visibleIndexPaths.first else { return 0}
        let currentIndex = currentVisibleIndexPath.item
        return currentIndex
    }
    private func bannerTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.bannerMove()
        }
    }
    private func bannerMove() {
        let currentIndex = self.computeCurrentIndex()
        var indexPath: IndexPath?
        if currentIndex == self.imageList.endIndex - 3 {
            indexPath = IndexPath(item: 2, section: 0)
        } else {
            indexPath = IndexPath(item: currentIndex + 1, section: 0)
        }
        guard let indexPath = indexPath else {return}
        self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
}

extension HomeBannerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel else {return}
        viewModel.computeLeftOffsetRatio(
            scrollView.contentSize.width,
            scrollView.contentOffset.x,
            scrollView.contentInset.left,
            scrollView.contentInset.right,
            self.imageList.count
        )
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentIndex = computeCurrentIndex()
        var indexPath: IndexPath?
        if currentIndex == self.imageList.endIndex - 1 {
            indexPath = IndexPath(item: 3, section: 0)
        } else if currentIndex == self.imageList.endIndex - 2 {
            indexPath = IndexPath(item: 2, section: 0)
        } else if currentIndex == 1 {
            indexPath = IndexPath(item: self.imageList.endIndex - 3, section: 0)
        } else if currentIndex == 0 {
            indexPath = IndexPath(item: self.imageList.endIndex - 4, section: 0)
        }
        guard let indexPath = indexPath else { return }
        self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
    }
}

extension HomeBannerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    func collectionView
    (
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(
                    withReuseIdentifier: "BannerCollectionViewCell",
                    for: indexPath
                ) as? HomeBannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUp(self.imageList[indexPath.item])
        return cell
    }
}
