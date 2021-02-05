//
//  Book.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 05.02.2021.
//

import UIKit

final class Book {

    let id: String = UUID().uuidString
    let title: String

    init(title: String) {
        self.title = title
    }
}
