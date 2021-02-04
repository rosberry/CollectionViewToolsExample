//
//  ProfileImageCollectionViewCell.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit

final class ProfileImageCollectionViewCell: UICollectionViewCell {
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.contentMode = .scaleAspectFill
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.center = contentView.center
        imageView.bounds = .init(origin: .zero, size: .init(width: 80, height: 80))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
