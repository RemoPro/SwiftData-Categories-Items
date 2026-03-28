//
//  AllItemsView.swift
//  SwiftData Categories Items
//
//  Created by Remo Prozzillo on 18.01.2026.
//

// show all items saved in the model

import SwiftUI
import SwiftData

struct AllItemsView: View {
    
    @Binding var selectedItem: Item?
    
    // Fetch all items
    @Query private var allItems: [Item]
    @Environment(\.modelContext) private var modelContext

    // add search
//    @State private var searchText = ""
//    init(nameFilter: String = "") {
//        // predicate is for describing conditions for SwiftData to filter data
//        let predicate = #Predicate<Item> { item in
//        /// include if title filter is empty or the movie contains the text in the filter
//            nameFilter.isEmpty || item.name.localizedStandardContains(nameFilter)
//        }
//        
//        _allItems = Query(filter: predicate, sort: \Item.name)
//    }
    
    var body: some View {
        
            // show all items
            ItemsView(items: allItems, title: "All Items", categoryId: nil)
//                .searchable(text: $searchText)
         
    }
}

#Preview {
    AllItemsView(selectedItem: .constant(nil))
}
