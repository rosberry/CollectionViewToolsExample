//
//  ViewController.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 29.01.2021.
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

final class HeaderCellItem: CollectionViewCellItem, DiffItem {
    typealias Cell = HeaderCollectionViewCell

    let reuseType: ReuseType = .class(Cell.self)

    let diffIdentifier: String

    private let title: String
    private let isHidden: Bool

    init(sectionHeader: SectionHeader) {
        diffIdentifier = sectionHeader.title + Cell.description()
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

final class MenuItemCollectionViewCell: UICollectionViewCell {
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

class SectionHeader {
    let title: String
    var isHidden: Bool = false

    init(title: String) {
        self.title = title
    }
}

class ViewController: UIViewController {

    private let menuItems: [[String]] = [["item1", "item2", "item3", "item4", "item5"],
                                         ["item6", "item7", "item8", "item9", "item10"]]
    private let sectionHeaders: [SectionHeader] = [.init(title: "Header1"), .init(title: "Header2")]

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

//        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: Constants.headerCellIdentifier)
//        collectionView.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: Constants.menuItemCellIdentifier)
//        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: Constants.menuItemCellIdentifier)

        collectionViewManager.update(makeSectionItems(), shouldReloadData: true)

        view.addSubview(collectionView)
        view.backgroundColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collectionView.frame = view.bounds
    }

    private func makeSectionItems2() -> [CollectionViewSectionItem] {
        let profileImageSectionItem = GeneralCollectionViewSectionItem()
        var menuSectionItems: [CollectionViewSectionItem] = []
        for index in 0..<sectionHeaders.count {
            let headerCellItem = HeaderCellItem(sectionHeader: sectionHeaders[index])
            let menuCellItems = menuItems[index].map { menuItem in
                MenuItemCellItem(title: menuItem)
            }
            let sectionItem = GeneralCollectionViewSectionItem(cellItems: [headerCellItem] + menuCellItems)
            menuSectionItems.append(sectionItem)
        }
        profileImageSectionItem.cellItems = [ProfileImageCellItem(image: UIImage(named: "profileImage")!)]
        return [profileImageSectionItem] + menuSectionItems
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
//
//extension ViewController: UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        sectionHeaders.count + 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        }
//        return menuItems[section].count + 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        if indexPath.section == 0 {
////            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.profileImageCellIdentifier, for: indexPath)
////            if let cell = cell as? ProfileImageCollectionViewCell {
////                cell.image = profileImage
////            }
////            return cell
////        }
//        if indexPath.row == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.headerCellIdentifier, for: indexPath)
//            if let cell = cell as? HeaderCollectionViewCell {
//                cell.title = sectionHeaders[indexPath.section]
//            }
//            return cell
//        }
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.menuItemCellIdentifier, for: indexPath)
//        if let cell = cell as? MenuItemCollectionViewCell {
//            cell.title = menuItems[indexPath.section][indexPath.row - 1]
//        }
//        return cell
//    }
//}
//
//extension ViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: collectionView.bounds.width, height: 50)
//    }
//}
class Test {
    let test: String = ""


    init() {
        test.split(separator: " ")
    }
}
