//
//  ContentView.swift
//  SwiftData Categories Items
//
//  Created by Remo Prozzillo on 28.03.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedCategory: Category?
    @State private var selectedItem: Item?
    
    var body: some View {
        NavigationSplitView {
            
            // 1 Categories
            CategoriesView(selectedCategory: $selectedCategory)
            
        } content: {
            // 2 Items in category
            if let category = selectedCategory {
                CategoryView(category: category, selectedItem: $selectedItem)
            } else {
                ContentUnavailableView("Select a category", systemImage: "questionmark")
            }
            
        } detail: {
            // 3 item detail
            if let item = selectedItem {
                ItemDetailView(item: item)
//            } else if let category = selectedCategory {
//                ContentUnavailableView("Select a product in \(category.name)", systemImage: "bag")
            } else {
                ContentUnavailableView("Select a item", systemImage: "questionmark")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    ContentView()
}

