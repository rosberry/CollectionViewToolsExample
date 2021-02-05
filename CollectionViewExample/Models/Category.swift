//
//  SectionHeader.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit

final class Category {

    let id: String = UUID().uuidString
    let title: String
    let books: [Book]
    var isHidden: Bool = false

    init(title: String, books: [Book] = []) {
        self.title = title
        self.books = books
    }
}

extension Category {

    static let fantasy: Category = .init(title: "Fantasy",
                                         books: [.init(title: "Alice in Wonderland"),
                                                 .init(title: "The Arabian Nights"),
                                                 .init(title: "The Time Machine"),
                                                 .init(title: "Collected Works of Poe"),
                                                 .init(title: "The Wonderful Wizard of Oz")])

    static let adventure: Category = .init(title: "Adventure",
                                           books: [.init(title: "The Adventures of Tom Sawyer"),
                                                   .init(title: "The Count of Monte Cristo"),
                                                   .init(title: "Around the World in 80 Days"),
                                                   .init(title: "Heart of Darkness"),
                                                   .init(title: "Abrakadabra")])
}
