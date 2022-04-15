//
//  AdditionalInfoView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-02-27.
//

import SwiftUI

struct AdditionalInfoView: View {
    @Binding var school: String
    @Binding var city: String
    @Binding var linkedin: String
    @Binding var instagram: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("School")
                .font(.headline)
            
            CustomInputField(imageName: "graduationcap",
                             placeholderText: "",
                             text: $school)
            
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
            
            Text("City")
                .font(.headline)
            
            CustomInputField(imageName: "building.2",
                             placeholderText: "",
                             text: $city)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
            
            Text("Linkedin")
                .font(.headline)
            
            CustomInputField(imageName: "plus.message",
                             placeholderText: "",
                             text: $linkedin)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
            
            Text("Instagram")
                .font(.headline)
            
            CustomInputField(imageName: "plus.message",
                             placeholderText: "",
                             text: $instagram)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
        }
        .padding()
    }
}
