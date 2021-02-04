//
//  SectionHeader.swift
//  CollectionViewExample
//
//  Created by Stas Klyukhin on 04.02.2021.
//

import UIKit

final class SectionHeader {
    let id: String = UUID().uuidString
    let title: String
    var isHidden: Bool = false

    init(title: String) {
        self.title = title
    }
}
