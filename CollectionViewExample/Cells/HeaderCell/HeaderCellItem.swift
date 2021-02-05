//
//  HeaderCellItem.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit
import CollectionViewTools

final class HeaderCellItem: CollectionViewCellItem, DiffItem {
    typealias Cell = HeaderCollectionViewCell

    let reuseType: ReuseType = .class(Cell.self)

    let diffIdentifier: String

    private let title: String
    private let isHidden: Bool

    init(sectionHeader: Category) {
        diffIdentifier = sectionHeader.id
        isHidden = sectionHeader.isHidden
        self.title = sectionHeader.title
    }

    func configure(_ cell: UICollectionViewCell) {
        guard let cell = cell as? Cell else {
            return
        }
        cell.title = "\(title) hidden: \(isHidden)"
    }

    func size(in collectionView: UICollectionView, sectionItem: CollectionViewSectionItem) -> CGSize {
        .init(width: collectionView.bounds.width, height: 40)
    }

    func isEqual(to item: DiffItem) -> Bool {
        guard let lhs = item as? Self else {
            return false
        }
        return lhs.title == title && lhs.isHidden == isHidden
    }
}
