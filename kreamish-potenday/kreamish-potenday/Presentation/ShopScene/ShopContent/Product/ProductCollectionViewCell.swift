//
//  ProductCollectionViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/05/18.
//
import Combine
import UIKit

import SnapKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static var id: String {  // computed property. 메모리 공간 가지지 않음.
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    
    @Published var product: Product?
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private lazy var englishNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private lazy var priceTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        label.text = "즉시 구매가"
        return label
    }()
    private lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    private lazy var bookMarkCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        return label
    }()
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.bubble"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    private lazy var commentCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private func configureUI() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(brandLabel)
        contentView.addSubview(englishNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceTypeLabel)
        contentView.addSubview(bookMarkButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(bookMarkCountLabel)
        contentView.addSubview(commentCountLabel)
        
        thumbnailImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(10)
            make.width.equalToSuperview()
            make.height.equalTo(thumbnailImageView.snp.width)
        })
        brandLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
        })
        englishNameLabel.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(brandLabel.snp.bottom).offset(8)
        })
        priceLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(englishNameLabel.snp.bottom).offset(8)
        })
        priceTypeLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
        })
        bookMarkButton.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(priceTypeLabel.snp.bottom).offset(10)
        })
        bookMarkCountLabel.snp.makeConstraints({ make in
            make.leading.equalTo(bookMarkButton.snp.trailing).offset(2)
            make.centerY.equalTo(bookMarkButton)
        })
        commentButton.snp.makeConstraints({ make in
            make.leading.equalTo(bookMarkCountLabel.snp.trailing).offset(10)
            make.top.equalTo(priceTypeLabel.snp.bottom).offset(10)
        })
        commentCountLabel.snp.makeConstraints({ make in
            make.leading.equalTo(commentButton.snp.trailing).offset(2)
            make.centerY.equalTo(commentButton)
        })
    }
    func setUp() {
        $product.sink { [weak self] newProduct in
            self?.bind()
        }
        .store(in: &cancellables)
        configureUI()
    }
    private func bind() {
        if let product = product {
            DispatchQueue.global().async {
                if let url = URL(string: product.imageUrl) {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = UIImage(data: data ?? Data())
                    }
                }
            }
            brandLabel.text = product.brandName
            englishNameLabel.text = product.name
            priceLabel.text = "\(product.recentPrice) 원"
            bookMarkCountLabel.text = "\(product.likeCount)"
            commentCountLabel.text = "\(product.commentCount)"
        }
    }
}
