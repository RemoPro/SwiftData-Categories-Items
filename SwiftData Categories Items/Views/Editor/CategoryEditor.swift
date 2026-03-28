//
//  CategoryEditor.swift
//  SwiftData Categories Items
//
//  Created by Remo on 17.01.2026.
//

import SwiftUI
import SwiftData

struct CategoryEditor: View {
    // optional pass a category for editing
//    var category: Category?
    @Bindable var category: Category
    /// tell the view if the passed category is new or for editing
    let isNew: Bool
    
    @Environment(\.modelContext) private var modelContext
    // For exiting
    @Environment(\.dismiss) private var dismiss
    
    // check if the view is adding or editing
    private var editorTitle: String {
        /// check if a category was passed
//        category == nil ? "Add category" : "Edit category"
        /// check if the passed category is the new empty
        category.name == "" ? "Add category" : "Edit category"
//        isNew == true ? "Add category" : "Edit category"
    }
    
    private func save() {
        if isNew == true {
            /// A new category was created but not yet saved, so make it now
            let newCategory = Category(name: name, iconName: iconName)
            modelContext.insert(newCategory)
            
        } else {
            // existing category was passed
            category.name = name
            category.iconName = iconName
        }
    }
    
    // Now for all values of the model
    @State private var name = ""
    @State private var iconName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                HStack {
                    Text(Image(systemName: iconName))
                    TextField("Icon name", text: $iconName)
                    // TODO: add a icon preview?
                }
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
                    .accessibilityLabel(name == "" ? "A name is required to save but you didn't provide one yet" : "Save")
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
            /// check if a existing category was passed
            .onAppear {
//                if let category {
//                    // asign its values to the local variables
                    name = category.name
                    iconName = category.iconName
//                }
//                if category.name == "" {
//                    isNew = true
//                } else {
//                    isNew = false
//                }
            }
            #if os(macOS)
            .padding()
            #endif
        } // NavigationStack
    }
}

#Preview("Add category") {
//    CategoryEditor(category: nil)
    @Previewable var category = Category(name: "")
    CategoryEditor(category: category, isNew: true)
}

#Preview("Edit category") {
    @Previewable var category = Category(name: "Test")
    CategoryEditor(category: category, isNew: false)
}
