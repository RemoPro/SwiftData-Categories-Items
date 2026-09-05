//
//  CategoryEditor.swift
//  SwiftData Categories Items
//
//  Created by Remo on 17.01.2026.
//

import SwiftUI
import SwiftData

struct CategoryEditor: View {
    // optional pass a category (for editing)
    var category: Category?
    
    @Environment(\.modelContext) private var modelContext
    // For exiting
    @Environment(\.dismiss) private var dismiss
    
    // Now for all values of the model
    @State private var name = ""
    @State private var iconName = ""
    
    private func save() {
        if category == nil {
            // no category was passed
            let newCategory = Category(name: name, iconName: iconName)
            modelContext.insert(newCategory)
        } else if category != nil {
            // existing category was passed
            category!.name = name
            category!.iconName = iconName
        }
    }
    
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
                    Text(category == nil ? "New category" : "Edit category")
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
                if let category {
                    // asign its values to the local variables
                    name = category.name
                    iconName = category.iconName
                }
            }
            #if os(macOS)
            .padding()
            #endif
        } // NavigationStack
    }
}

#Preview("Add") {
    CategoryEditor()
}

#Preview("Edit category") {
    @Previewable var category = Category(name: "Test")
    CategoryEditor(category: category)
}
