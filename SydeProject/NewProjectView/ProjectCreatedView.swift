//
//  ProjectCreatedView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-04-01.
//

import SwiftUI

struct ProjectCreatedView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.purple)
                .padding(.vertical)
            Text("Project Created!")
                .font(.title2)
            
            Button{
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Create another project")
                    .foregroundColor(.purple)
                    .font(.headline)
            }
            .padding(.vertical, 40)
        }
        
    }
}

struct ProjectCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCreatedView()
    }
}
