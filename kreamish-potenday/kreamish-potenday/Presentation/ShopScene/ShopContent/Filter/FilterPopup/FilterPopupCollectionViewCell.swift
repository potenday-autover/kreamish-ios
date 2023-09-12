//
//  FilterPopupCollectionViewCell.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/07/01.
//

import UIKit

class FilterPopupCollectionViewCell: UICollectionViewCell {
    static var id: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.contentView.backgroundColor = .black
                self.label.textColor = .white
                // count api 호출해야함
            } else {
                self.contentView.backgroundColor = .white
                self.label.textColor = .black
                // count api 호출해야함
            }
        }
    }
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    func configureUI() {
        self.contentView.layer.cornerRadius = contentView.bounds.height / 2.3
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    func setUp(itemName: String) {
        label.text = itemName
        configureUI()
    }
}
