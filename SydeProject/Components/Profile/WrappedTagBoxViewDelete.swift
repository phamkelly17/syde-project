//
//  WrappedTagBoxViewDelete.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-17.
//

import SwiftUI

struct WrappedTagBoxViewDelete: View {
    @Binding var tags: [String]
    
    init(_ tags: Binding<[String]>) {
        self._tags = tags
    }
    
    var body: some View {
        HStack {
            TagsViewDelete(items: tags)
                .padding()
            
            Spacer()
        }
        .background(Color.purple.opacity(0.2))
        .cornerRadius(15)
    }

}
