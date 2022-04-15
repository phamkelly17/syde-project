//
//  AddInterestsView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-02-27.
//

import SwiftUI

struct AddInterestsView: View {
    let placeholder:String
    @State private var typeInterest = ""
    @Binding var interestsList: [String]

    
    var body: some View {
        VStack {
            HStack {
                CustomInputField(imageName: "plus",
                                 placeholderText: placeholder,
                                 text: $typeInterest)
                Button {
                    interestsList.append(typeInterest)
                    typeInterest = ""
                } label: {
                    Text("Add")
                        .foregroundColor(.black)
                        .padding(5)
                        .background(Color.purple.opacity(0.5))
                        .cornerRadius(7)
                }


            }
            
            WrappedTagBoxView($interestsList)
            
            Button {
                interestsList = []
            } label: {
                HStack{
                    Spacer()
                    Image(systemName:"trash")
                        Text("Remove Interests")
                }
            }
            .foregroundColor(.black)
            .padding(.vertical)
        }
        

    }
}
