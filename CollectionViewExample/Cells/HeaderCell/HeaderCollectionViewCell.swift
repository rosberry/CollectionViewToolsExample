//
//  HeaderCollectionViewCell.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit

final class HeaderCollectionViewCell: UICollectionViewCell {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemPurple
        contentView.addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}
