//
//  TextArea.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-13.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    let imageName: String
    
    init(_ placeholder: String, text: Binding<String>, _ imageName: String){
        self.placeholder = placeholder
        self._text = text
        self.imageName = imageName
        UITextView.appearance().backgroundColor = .clear
    }
    var body: some View {
        VStack {
            HStack (alignment: .top){
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width:20, height: 20)
                    .foregroundColor(Color(.systemPurple))
                
                ZStack(alignment: .topLeading){
                    
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(Color(.placeholderText))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .multilineTextAlignment(.leading)
                    }
                    
                    TextEditor(text: $text)
                        .multilineTextAlignment(.leading)
                }
                .font(.body)
            }
            
            Divider()
                .background(Color(.darkGray))
        }

    }
}
