//
//  CategoryView.swift
//  SwiftData Categories Items
//
//  Created by Remo Prozzillo on 18.01.2026.
//

// show all items from a category
import SwiftUI
import SwiftData

struct CategoryView: View {
    // pass the category to this view
    let category: Category
    
    @Binding var selectedItem: Item?
    
//    @Environment(\.modelContext) private var modelContext
    
    
    
    var body: some View {
        
        // items are optional in the category so we need to unwrap them
        if let items = category.items {
            
            // Now pass the items to ItemsView
            /// and a ForEach inside
            ItemsView(items: items, title: category.name, categoryId: category.id)
            
        } else {
            ContentUnavailableView("Select a item", systemImage: "questionmark")
        }
    }
}

#Preview {
    @Previewable var category = Category(
        name: "Category",
        iconName: "folder",
        items: [
            Item(
                name: "Item",
                category: nil
            )
        ]
    )
    
    CategoryView(category: category, selectedItem: .constant(nil))
}

