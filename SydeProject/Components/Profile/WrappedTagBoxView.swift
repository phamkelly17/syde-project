//
//  WrappedTagBoxView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI

struct WrappedTagBoxView: View {
    @Binding var tags: [String]
    
    init(_ tags: Binding<[String]>) {
        self._tags = tags
    }
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
