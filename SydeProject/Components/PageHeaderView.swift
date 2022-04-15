//
//  PageHeaderView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI

struct PageHeaderView: View {
    @Environment(\.presentationMode) var mode
    let title:String
    var body: some View {
        HStack {
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrowtriangle.backward.fill")
                    .foregroundColor(.black)
            }
            .padding()
            
            Text(title)
                .font(.title)
        }
        .padding(.vertical)
        .frame(height: 30)
    }
}

struct PageHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PageHeaderView(title:"Test")
    }
}
