//
//  CategoriesView.swift
//  SwiftData Categories Items
//
//  Created by Remo Prozzillo on 17.01.2026.
//

// 1. View, in sidebar leading showing all categories

import SwiftUI
import SwiftData

struct CategoriesView: View {
    
    @Binding var selectedCategory: Category?
    
    // Fetch all categories
    @Query private var categories: [Category]
    // and fetch all ittems to show the number of items. When costing to much performance it must be removed
    @Query private var allItems: [Item]
    @Environment(\.modelContext) private var modelContext
    
    // Add/Edit sheets
    @State private var showSheetAddNewCategory = false
    @State private var editCategory: Category?
    @State private var showAlertDeletingCatogory = false
    @State private var deleteCategory: Category?
    
    var body: some View {
        List {
        // TODO: View for all categories first?
        NavigationLink(destination: AllItemsView(selectedItem: .constant(nil))) {
            LabeledContent {
                // show how many items are in the category
                Text("\(allItems.count > 0 ? "\(allItems.count)" : "0")")
                    .accessibilityLabel("\(allItems.count > 0 ? "\(allItems.count)" : "0") items")
            } label: {
                Label("All Items", systemImage: "list.dash")
            }
        }
        
            ForEach(categories) { category in
                
                NavigationLink(destination: CategoryView(category: category, selectedItem: .constant(nil))) {
                    LabeledContent {
                        // show how many items are in the category
                        //                    Text("0")
                        Text("\(category.items!.count)")
                            .accessibilityLabel("\(category.items!.count) items")
                    } label: {
                        Label(category.name, systemImage: category.iconName)
                    }
                }
                .contextMenu {
                    // Edit
                    Button("Edit", systemImage: "pencil") {
                        editCategory = category
                    }
                    
                    // Delete…
                    Button("Delete…", systemImage: "trash", role: .destructive) {
                        /// for delete we must have access to it
                        deleteCategory = category
                        /// And show the alert
                        showAlertDeletingCatogory = true
                    }
                } // contextMenu
            } // ForEach
        } // List
        .navigationTitle("Categories")
        .toolbar {
            ToolbarItem {
                Button("Add Category", systemImage: "plus") {
                    showSheetAddNewCategory = true
                }
            }
        } // toolbar
        // Add new category
        .sheet(isPresented: $showSheetAddNewCategory) {
            // set default values
            let newCategory = Category(name: "", iconName: "folder")
            CategoryEditor(category: newCategory, isNew: true)
        }
        // Edit category
        .sheet(item: $editCategory) { category in
            CategoryEditor(category: category, isNew: false)
        }
        /// check if deleteCategory exists to show its name
        .alert(
            "Delete \(deleteCategory != nil ? deleteCategory!.name : "Category")?",
            isPresented: $showAlertDeletingCatogory,
            actions: {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(deleteCategory!)
                }
            }, message: {
                Text("The items will remain without a category.")
            }
        ) // alert
        
    }
}

#Preview {
    CategoriesView(selectedCategory: .constant(nil))
}
