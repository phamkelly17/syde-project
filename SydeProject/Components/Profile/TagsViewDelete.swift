//
//  TagsViewDelete.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-17.
//

import SwiftUI

struct TagsViewDelete: View {
    let items: [String]
    var groupedItems: [[String]] = [[String]]()
    let screenWidth = UIScreen.main.bounds.width
    
    init(items: [String]){
        self.items = items
        groupedItems = createGroupedItems(items: items, screenWidth: screenWidth, extraWidth: 64)
    }
    

    var body: some View {
        VStack (alignment: .leading){
            ForEach(groupedItems, id: \.self) {subItem in
                HStack {
                    ForEach(subItem, id: \.self) { word in
                        Button {
                            print("deleting tag")
                        } label: {
                            HStack {
                                Text(word)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                
                                Image(systemName:"xmark")
                                    .foregroundColor(.purple)
                            }
                            .padding(5)
                            .background(Color.purple.opacity(0.5))
                            .cornerRadius(10)
                        }

                    }
                }
            }
        }
    }

}

struct TagsViewDelete_Previews: PreviewProvider {
    static var previews: some View {
        TagsViewDelete(items:["HTML","CSS"])
    }
}
