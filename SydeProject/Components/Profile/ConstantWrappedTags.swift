//
//  ConstantWrappedTags.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-03.
//


import SwiftUI

struct ConstantWrappedTags: View {
    let tags: [String]
    
    var body: some View {
        HStack {
            TagsView(items: tags)
                .padding()
            
            Spacer()
        }
        .background(Color.purple.opacity(0.2))
        .cornerRadius(15)
    }
}
