//
//  ProductTableViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/18.
//
import Combine
import UIKit

import iOSDropDown
import SnapKit

protocol CollectionViewCellDelegate {
    func selectedCollectionViewCell(product: Product)
}

class ProductTableViewCell: UITableViewCell {
    private var cancellables = Set<AnyCancellable>()
    static var id: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    var productsPage: ProductsPage? = nil
    var delegate: CollectionViewCellDelegate?
    
    static let cellHeight = 3000.0
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    let sortDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.optionArray = ["인기순", "즉시 구매가순", "즉시 판매가순", "관심 많은순", "발매일순"]
        dropDown.font = UIFont.systemFont(ofSize: 16, weight: .light)
        dropDown.text = dropDown.optionArray[0]
        dropDown.textAlignment = .left
        dropDown.isSearchEnable = false
        dropDown.checkMarkEnabled = false
        dropDown.selectedRowColor = .lightGray
        dropDown.selectedIndex = 0
        dropDown.arrowSize = 16
        dropDown.rowHeight = 60
        dropDown.listHeight = dropDown.rowHeight * CGFloat(dropDown.optionArray.count)
        return dropDown
    }()
    lazy var productCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .white
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.id)
        return collectionView
    }()
    
    private func configureUI() {
        countLabel.text = "상품 \(productsPage?.totalElements ?? 0)"
        
        self.contentView.addSubview(countLabel)
        self.contentView.addSubview(sortDropDown)
        self.contentView.addSubview(productCollectionView)
        countLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        sortDropDown.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(140)
            $0.height.equalTo(countLabel.snp.height)
        }
        productCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(countLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.centerX.equalToSuperview()
//            $0.height.lessThanOrEqualTo()
        }
    }
    
    func setUp(category: Category) {
        // DI. 나중에 DI Container로 뺄 예정.
        let dataTransferService = DefaultDataTransferService(
            with: DefaultNetworkService(config: ApiDataNetworkConfig(baseURL: URL(string: Constants.DEFAULT_DOMAIN)!))
        )
        let productsRepository = DefaultProductsRepository(dataTransferService: dataTransferService)
        let getProductsUseCase = DefaultGetProductsUseCase(productsRepository: productsRepository)
        
        let viewModel = ProductListViewModel(getProductsUseCase: getProductsUseCase, categoryIds: "\(category.categoryId)", brandIds: nil, collectionIds: nil)
        // DI. 나중에 DI Container로 뺄 예정.
        
        // combine. 데이터 변화를 감지함
        viewModel.$productsPage
                    .sink { [weak self] updatedProductsPage in
                        // Call your specific function in the ViewController
                        guard let productsPage = updatedProductsPage else {
                            return
                        }
                        self?.productsPage = productsPage
                        self?.configureUI()
                    }
                    .store(in: &cancellables)
        
        viewModel.getProductsPage()
    }
}

extension ProductTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productsPage?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.id, for: indexPath)
        guard let cell = cell as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
//        cell.model = productList[indexPath.item]
        cell.product = productsPage?.products[indexPath.item]
        cell.setUp()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productsPage?.products[indexPath.item]
        if let delegate = delegate {
            delegate.selectedCollectionViewCell(product: product!)
        }
    }
}

extension ProductTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 5
        //            let lineSpacing: CGFloat = 10
        let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 2
        let height: CGFloat = width * 2.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
