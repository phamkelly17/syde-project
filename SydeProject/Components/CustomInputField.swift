//
//  CustomInputField.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI

struct CustomInputField: View {
    let imageName:String
    let placeholderText:String
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {
        VStack{
            HStack {
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.purple)
                
                if isSecureField ?? false{
                    SecureField(placeholderText, text: $text)
                        .multilineTextAlignment(.leading)
                } else {
                    TextField(placeholderText, text: $text)
                        .multilineTextAlignment(.leading)
                }

            }
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "plus",
                         placeholderText: "Add Schools",
                        text: .constant(""))
    }
}

