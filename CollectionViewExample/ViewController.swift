//
//  ViewController.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 29.01.2021.
//

import UIKit

class ViewController: UIViewController {

    private enum Constants {
        static let headerCellIdentifier: String = "headerCellIdentifier"
        static let menuItemCellIdentifier: String = "menuItemCellIdentifier"
        static let profileImageCellIdentifier: String = "profileImageCellIdentifier"
    }

    private let menuItems: [[String]] = [["item1", "item2", "item3", "item4", "item5"],
                                         ["item6", "item7", "item8", "item9", "item10"]]
    private let sectionHeaders: [String] = ["Header1", "Header2"]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: Constants.headerCellIdentifier)
        collectionView.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: Constants.menuItemCellIdentifier)
        collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.profileImageCellIdentifier)

        view.addSubview(collectionView)
        view.backgroundColor = .white

        collectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collectionView.frame = view.bounds
    }
}

extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionHeaders.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return menuItems[section - 1].count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.profileImageCellIdentifier, for: indexPath)
            if let cell = cell as? ProfileImageCollectionViewCell {
                cell.image = UIImage(named: "profileImage")!
            }
            return cell
        }
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.headerCellIdentifier, for: indexPath)
            if let cell = cell as? HeaderCollectionViewCell {
                cell.title = sectionHeaders[indexPath.section - 1]
            }
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.menuItemCellIdentifier, for: indexPath)
        if let cell = cell as? MenuItemCollectionViewCell {
            cell.title = menuItems[indexPath.section - 1][indexPath.row - 1]
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: collectionView.bounds.width, height: 200)
        }
        return .init(width: collectionView.bounds.width, height: 50)
    }
}
