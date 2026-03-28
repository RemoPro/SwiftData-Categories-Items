//
//  Item.swift
//  SwiftData Categories Items
//
//  Created by Remo Prozzillo on 17.01.2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var id: UUID
    var name: String
    var category: Category?
    
    init(
        id: UUID = UUID(),
        name: String = "",
        category: Category?
    ) {
        self.id = id
        self.name = name
        self.category = category
    }
}
