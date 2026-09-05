//
//  ItemsView.swift
//  SwiftData Categories Items
//
//  Created by Remo Prozzillo on 17.01.2026.
//

// View to display a list from items passed in an array to this view.

import SwiftUI
import SwiftData

struct ItemsView: View {
    // pass the items to this view
    let items: [Item]
    let title: String
    // get the category id to make sure the right is selected when adding a new item
    let categoryId: UUID?
    
//    @Binding var selectedItem: Item?
    
    @Environment(\.modelContext) private var modelContext
    
    // Add/Edit sheets
    @State private var showSheetAddItem = false
    @State private var editItem: Item?
    @State private var showAlertDeletingItem = false
    @State private var deleteItem: Item?
    
    var body: some View {
        // check if items exist
        if items.isEmpty {
            ContentUnavailableView("No items", systemImage: "questionmark")
        }
        List {
            
                ForEach(items) { item in
                    
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        VStack(alignment: .leading) {
                            Text(item.name)
                            // if the List with items is shown in AllItemsView show the category name underneath
                            if categoryId == nil {
                                Text(item.category?.name ?? "Unknown category")
                                    .font(.caption)
                            }
                        }
                    }
                    .contextMenu {
                        // Edit
                        Button("Edit", systemImage: "pencil") {
                            editItem = item
                        }
                        
                        // Delete…
                        Button("Delete…", systemImage: "trash", role: .destructive) {
                            /// for delete we must have access to it
                            deleteItem = item
                            /// And show the alert
                            showAlertDeletingItem = true
                        }
                        
                        // Share?
                        ShareLink(item: "\(item.name) \(item.category?.name ?? "Unknown category")",
                                  preview: SharePreview(item.name)
                        ) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                    } // contextMenu
                } // ForEach
         
            } // List
            .navigationTitle(title)
            .toolbar {
                ToolbarItem {
                    Button("Add Item", systemImage: "plus") {
                        showSheetAddItem = true
                    }
                }
            } // toolbar
            // Add new item
            .sheet(isPresented: $showSheetAddItem) {
                ItemEditor()
            }
            // Edit item
            .sheet(item: $editItem) { item in
                ItemEditor(item: item, categoryId: categoryId)
            }
            /// check if deleteItem exists to show its name
            .alert("Delete \(deleteItem != nil ? deleteItem!.name : "Item")?", isPresented: $showAlertDeletingItem) {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(deleteItem!)
                }
            }
            
//        } else {
//            ContentUnavailableView("Select a item", systemImage: "questionmark")
//        }
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
    
    ItemsView(items: category.items!, title: "Category", categoryId: category.id)
}

