//
//  HeaderCollectionViewCell.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit

final class HeaderCollectionViewCell: UICollectionViewCell {

    var addBookButtonHandler: (() -> Void)?


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

    private lazy var addBookButton: UIButton = {
        let view = UIButton()
        view.setTitle("Add book", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.addTarget(self, action: #selector(addBookButtonPressed), for: .touchUpInside)
        view.backgroundColor = .white
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemPurple
        contentView.addSubview(titleLabel)
        contentView.addSubview(addBookButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = contentView.bounds
        let addBookButtonSize = addBookButton.sizeThatFits(contentView.bounds.size)
        addBookButton.frame = .init(x: contentView.bounds.width - addBookButtonSize.width,
                                    y: 10,
                                    width: addBookButtonSize.width,
                                    height: contentView.bounds.height - 20)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    @objc private func addBookButtonPressed() {
        addBookButtonHandler?()
    }
}
