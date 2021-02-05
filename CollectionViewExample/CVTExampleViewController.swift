//
//  DiffExampleViewController.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit
import CollectionViewTools

class CVTExampleViewController: UIViewController {

    private let menuItems: [[String]] = [["item1", "item2", "item3", "item4", "item5"],
                                         ["item6", "item7", "item8", "item9", "item10"]]
    private let sectionHeaders: [Category] = [.init(title: "Header1"), .init(title: "Header2")]

    private lazy var collectionViewManager: CollectionViewManager = .init(collectionView: collectionView)

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewManager.update(makeSectionItems(), shouldReloadData: true)

        view.addSubview(collectionView)
        view.backgroundColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collectionView.frame = view.bounds
    }

    private func makeSectionItems() -> [CollectionViewDiffSectionItem] {
        let sectionItem = GeneralCollectionViewDiffSectionItem()
        var cellItems: [CollectionViewCellItem] = [ProfileImageCellItem(image: UIImage(named: "profileImage")!)]
        for index in 0..<sectionHeaders.count {
            let headerCellItem = HeaderCellItem(sectionHeader: sectionHeaders[index])
            headerCellItem.itemDidSelectHandler = { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.sectionHeaders[index].isHidden.toggle()
                self.collectionViewManager.update(with: self.makeSectionItems(), animated: true)
            }
            cellItems.append(headerCellItem)
            let menuItemCellItems = menuItems[index].map { menuItem in
                MenuItemCellItem(title: menuItem)
            }
            if !sectionHeaders[index].isHidden {
                cellItems.append(contentsOf: menuItemCellItems)
            }
        }
        sectionItem.cellItems = cellItems
        return [sectionItem]
    }
}
