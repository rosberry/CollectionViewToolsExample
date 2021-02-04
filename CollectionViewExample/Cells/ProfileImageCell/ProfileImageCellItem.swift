//
//  ProfileImageCellItem.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit
import CollectionViewTools

final class ProfileImageCellItem: CollectionViewCellItem, DiffItem {
    typealias Cell = ProfileImageCollectionViewCell

    let reuseType: ReuseType = .class(Cell.self)

    let diffIdentifier: String

    private let image: UIImage

    init(image: UIImage) {
        diffIdentifier = Cell.description()
        self.image = image
    }

    func configure(_ cell: UICollectionViewCell) {
        guard let cell = cell as? Cell else {
            return
        }
        cell.image = image
    }

    func size(in collectionView: UICollectionView, sectionItem: CollectionViewSectionItem) -> CGSize {
        .init(width: collectionView.bounds.width, height: 200)
    }

    func isEqual(to item: DiffItem) -> Bool {
        true
    }
}
