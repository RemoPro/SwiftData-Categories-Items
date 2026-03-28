//
//  ItemEditor.swift
//  SwiftData Categories Items
//
//  Created by Remo on 17.01.2026.
//

import SwiftUI
import SwiftData

struct ItemEditor: View {
    // pass item to this view
    @Bindable var item: Item
    /// tell the view if the passed category is new or for editing
    let isNew: Bool
    
    @Environment(\.modelContext) private var modelContext
    // For exiting
    @Environment(\.dismiss) private var dismiss
    
    // check if the view is adding or editing
    private var editorTitle: String {
        item.name == "" ? "Add item" : "Edit item"
    }
    
    // for adding a new category
    @State private var showSheetAddNewCategory = false
    
    // Now for all values of the model
    @State private var name = ""
    @State private var category: Category? = nil
//    @State private var categoryName: String?
    
    // fetch existing categories
    @Query(sort: \Category.name) private var categories: [Category]
    func searchCategoryByName(name: String) -> Category? {
        categories.first(where: { $0.name == name })
    }
    func searchCategoryByUUID(id: UUID) -> Category? {
        categories.first(where: { $0.id == id })
    }

    private func save() {
        if isNew == true {
            /// A new category was created but not yet saved, so make it now
            let newItem = Item(name: name, category: category)
            modelContext.insert(newItem)
            
        } else {
            // existing category was passed
            item.name = name
            item.category = category
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent("Name") {
                    TextField("Name", text: $name)
                }
                
                Picker("Category", selection: $category) {
                    /// Create a selection for none
                    Label("None", systemImage: "xmark.app")
                        .tag(nil as Category?)
                    Divider()
                    
                    // TODO: When multiple categories have the same name only one is shown despite each catergory having therir own id
                    ForEach(categories) { category in
                        Label(category.name, systemImage: category.iconName)
                            .tag(category)
                    }
//                    Divider()
//                    // TODO: add an option to create a new category?
//                    Label("New…", systemImage: "plus")
//                        .tag(nil as Category?)
//                        .onTapGesture {
//                            showSheetAddNewCategory = true
//                        }
                }
//                .onChange(of: category) { newValue in
//                .onChange(of: categoryName) {
//                if categoryName == "new" {
//                        showSheetAddNewCategory = true
//                    }
//                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                
                // save
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    // Require a name to save changes (when adding a new)
                    .disabled(name == "")
                }
                
                // cancel
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        withAnimation {
                            dismiss()
                        }
                    }
                }
            } // toolbar
            // check if a existing category was passed
            .onAppear {
//                if let item {
                    // asign its values to the local variables
                    name = item.name
                // Now we have a View that shows all items, which means that now it also could have items without a category. Not ideal
                if (item.category != nil) {
                    category = item.category
                }
                // check if category.name has a value
                if let itemCategoryExists = item.category {
//                    category = searchCategoryByName(name: itemCategoryExists.name)
                    category = searchCategoryByUUID(id: itemCategoryExists.id)
                }
                /// since we are fetching all categories in this view can we search for the category by name?
            }
            // Add new category
            .sheet(isPresented: $showSheetAddNewCategory) {
                let newCategory = Category(name: "", iconName: "")
                CategoryEditor(category: newCategory, isNew: true)
            }
            #if os(macOS)
            .padding()
            #endif
        } // NavigationStack
    }
}

#Preview("Add item") {
    @Previewable var item = Item(name: "", category: Category(name: ""))
    ItemEditor(item: item, isNew: true)
}

#Preview("Edit item") {
    @Previewable var item = Item(name: "Test", category: Category(name: ""))
    ItemEditor(item: item, isNew: false)
}

