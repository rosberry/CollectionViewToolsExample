//
//  DiffExampleViewController.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit
import CollectionViewTools

class CVTExampleViewController: UIViewController {

    private let categories: [Category] = [.fantasy, .adventure]

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

        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonPressed))
        navigationItem.rightBarButtonItem = plusButton

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
        for index in 0..<categories.count {
            let headerCellItem = HeaderCellItem(category: categories[index])
            headerCellItem.addBookButtonHandler = { [weak self] in
                guard let self = self else {
                    return
                }
                self.categories[index].books.insert(.init(title: "New book"), at: 0)
                self.collectionViewManager.update(with: self.makeSectionItems(), animated: true)
            }
            headerCellItem.itemDidSelectHandler = { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.categories[index].isHidden.toggle()
                self.collectionViewManager.update(with: self.makeSectionItems(), animated: true)
            }
            cellItems.append(headerCellItem)
            let bookCellItems = categories[index].books.map { book in
                BookCellItem(title: book.title)
            }
            if !categories[index].isHidden {
                cellItems.append(contentsOf: bookCellItems)
            }
        }
        sectionItem.cellItems = cellItems
        return [sectionItem]
    }

    private func addBook(to headerCellItem: HeaderCellItem) {
        let sectionItem = collectionViewManager.sectionItems.first ?? GeneralCollectionViewSectionItem()
        let index = sectionItem.cellItems.firstIndex { cellItem -> Bool in
            cellItem === headerCellItem
        }
        let cellItem = BookCellItem(title: "New book")
        if let index = index {
            collectionViewManager.insert([cellItem], to: sectionItem, at: [index + 1])
        }
    }

    @objc private func plusButtonPressed() {
        let sectionItem = collectionViewManager.sectionItems.first ?? GeneralCollectionViewSectionItem()
        let cellItem = BookCellItem(title: "New")
        collectionViewManager.prepend([cellItem], to: sectionItem)
    }
}
