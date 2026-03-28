//
//  Category.swift
//  SwiftData Categories Items
//
//  Created by Remo Prozzillo on 17.01.2026.
//


import Foundation
import SwiftData

@Model
final class Category {
    var id: UUID
    var name: String
    var iconName: String
    var items: [Item]?

    init(
        id: UUID = UUID(),
        name: String = "",
        iconName: String = "",
        items: [Item] = []
    ) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.items = items
    }
}
