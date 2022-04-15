//
//  ConstantInputField.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-02-27.
//

import SwiftUI

struct ConstantInputField: View {
    let email: String
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image(systemName: "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.purple)
                
                Text(email)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
            }
            Divider()
                .background(Color(.darkGray))
        }
    }
}
