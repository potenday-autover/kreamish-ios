//
//  FilterTableViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/06.
//

import Combine
import UIKit

class FilterTableViewCell: UITableViewCell {
    
    static var id: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    static let cellHeight = 70.0
    
    var selectFilterCellClosure: ((Int) -> Void)?
    
    var viewModel: FilterViewModel?
    
    private lazy var filterCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.id)
        return collectionView
    }()
    
    private func configureUI() {
        self.contentView.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalToSuperview()
        }
    }
    
    func setUp(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        self.configureUI()
    }
}

extension FilterTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.id, for: indexPath) as? FilterCollectionViewCell
                , let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        cell.filter = viewModel.filterList[indexPath.item]
        cell.setUp()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectFilterCellClosure?(indexPath.item)
    }
}

extension FilterTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.id, for: indexPath) as? FilterCollectionViewCell
                , let viewModel = viewModel else {
            return .zero
        }
        cell.label.text = viewModel.filterList[indexPath.item].name
        cell.label.sizeToFit()  // sizeToFit() : 텍스트에 맞게 사이즈가 조절
        let width = cell.label.frame.width + 40
        let height: CGFloat = 40.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
