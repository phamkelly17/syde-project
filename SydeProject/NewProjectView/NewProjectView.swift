//
//  NewProjectView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-11.
//

import SwiftUI

struct NewProjectView: View {
    private var tags = ["ios", "Frontend", "Swift", "UI/UX", "Mobile Development"]
    @State private var toDevelop = false
    @State private var forDevelopers = false
    @State private var projectTitle = ""
    @State private var overview = ""
    @State private var details = ""
    @State private var typeTag = ""
    @State private var school = ""
    @State private var city = ""
    @State private var fromDate = Date.now
    @State private var toDate = Date.now
    @State private var minMembers = 1
    @State private var maxMembers = 1
    var body: some View {
        VStack (alignment: .leading){
            
            pageHeader
            
            ScrollView{
                LazyVStack (alignment: .leading) {
                    EditProjectTemplateView(toDevelop:false, forDevelopers:false, projectTitle:"",overview:"",details:"", typeTag:"", tags:[], school:"", city:"", fromDate:Date.now, toDate:Date.now, minMembers:1,maxMembers:1)
                }
            }
        }
        .padding()
        .navigationTitle("New Project")
        .navigationBarHidden(true)
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectView()
    }
}

extension NewProjectView {
    var pageHeader: some View {
        HStack {
            Image("logo-icon")
                .resizable()
            .frame(width:50, height: 50)
            
            Text("Create a New Project")
                .font(.title)
        }
    }
}
