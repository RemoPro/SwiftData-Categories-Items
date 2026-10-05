//
//  ProductDetailView.swift
//  SwiftData Categories Items
//
//  Created by Remo Prozzillo on 17.01.2026.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        List {
            LabeledContent("Name") {
                Text(item.name)
            }
            LabeledContent("Category") {
                    Label(item.category?.name ?? "No category", systemImage: item.category?.iconName ?? "questionmark.circle")
            }
        }
        .navigationTitle(item.name)
    }
}

#Preview {
    ItemDetailView(item: SampleData.shared.item)
}
