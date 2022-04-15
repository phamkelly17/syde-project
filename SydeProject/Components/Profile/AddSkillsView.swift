//
//  AddSkillsView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-02-27.
//

import SwiftUI

struct AddSkillsView: View {
    let placeholder:String
    @State private var typeSkill = ""
    //@State private var removeSkills = false
    @Binding var skillsList: [String]

    
    var body: some View {
        VStack {
            HStack {
                CustomInputField(imageName: "plus",
                                 placeholderText: placeholder,
                                 text: $typeSkill)
                Button {
                    skillsList.append(typeSkill)
                    typeSkill = ""
                } label: {
                    Text("Add")
                        .foregroundColor(.black)
                        .padding(5)
                        .background(Color.purple.opacity(0.5))
                        .cornerRadius(7)
                }


            }

            WrappedTagBoxView($skillsList)

            Button {
                skillsList = []
            } label: {
                HStack{
                    Spacer()
                    Image(systemName:"trash")
                    Text("Remove Skills")

                }
            }
            .foregroundColor(.black)
            .padding(.vertical)
        }
        

    }
}
