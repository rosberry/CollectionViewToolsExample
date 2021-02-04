//
//  MenuItemCellItem.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit
import CollectionViewTools

final class MenuItemCellItem: CollectionViewCellItem, DiffItem {

    typealias Cell = MenuItemCollectionViewCell

    let reuseType: ReuseType = .class(Cell.self)

    let diffIdentifier: String

    private let title: String

    init(title: String) {
        diffIdentifier = title + Cell.description()
        self.title = title
    }

    func configure(_ cell: UICollectionViewCell) {
        guard let cell = cell as? Cell else {
            return
        }
        cell.title = title
    }

    func size(in collectionView: UICollectionView, sectionItem: CollectionViewSectionItem) -> CGSize {
        .init(width: collectionView.bounds.width, height: 40)
    }

    func isEqual(to item: DiffItem) -> Bool {
        guard let lhs = item as? Self else {
            return false
        }
        return lhs.title == title
    }
}
