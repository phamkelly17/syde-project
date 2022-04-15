//
//  TagsView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI

struct TagsView: View {
    
    let items: [String]
    var groupedItems: [[String]] = [[String]]()
    let screenWidth = UIScreen.main.bounds.width
    
    init(items: [String]){
        self.items = items
        groupedItems = createGroupedItems(items: items, screenWidth: screenWidth, extraWidth: 32)
    }
    

    var body: some View {
        VStack (alignment: .leading){
            ForEach(groupedItems, id: \.self) {subItem in
                HStack {
                    ForEach(subItem, id: \.self) { word in
                        Text(word)
                            .font(.headline)
                            .padding(5)
                            .background(Color.purple.opacity(0.5))
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}
