//
//  EditProjectTemplateView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-17.
//

import SwiftUI

struct EditProjectTemplateView: View {
    @State var toDevelop:Bool
    @State var forDevelopers:Bool
    @State var projectTitle: String
    @State var overview: String
    @State var details: String
    @State var typeTag: String
    @State var tags: [String]
    @State var school: String
    @State var city: String
    @State var fromDate:Date
    @State var toDate:Date
    @State var minMembers:Int
    @State var maxMembers:Int
    @State private var projectCreated = false
        
    @State private var removeTagsView = false
    
    @ObservedObject var viewModel = UploadProjectViewModel()
    
    var body: some View {
        
        VStack {
            ScrollView{
                LazyVStack (alignment: .leading) {
                    typeProject
                    projectInfo
                    projectInfo2
                    timeline
                    membersNeeded
                    createButton

                }
                .foregroundColor(.black)
            }
        }

    }
}

extension EditProjectTemplateView {
    
    var typeProject: some View {
        VStack (alignment: .leading){
            Text("I'm looking...")
                .font(.caption)
            
            HStack (alignment: .top){
                Button {
                    toDevelop.toggle()
                    if forDevelopers {
                        forDevelopers.toggle()
                    }
                    
                } label: {
                    if toDevelop {
                        Image(systemName: "square.fill")
                            .foregroundColor(.purple)
                    } else {
                        Image(systemName: "square")
                            .foregroundColor(.purple)
                    }
                    
                }
                
                Text("to develop a project")
                    .font(.caption)
                    .frame(width: 120)
                
                Spacer()
                Button {
                    forDevelopers.toggle()
                    if toDevelop {
                        toDevelop.toggle()
                    }
                } label: {
                    if forDevelopers {
                        Image(systemName: "square.fill")
                            .foregroundColor(.purple)
                    } else {
                        Image(systemName: "square")
                            .foregroundColor(.purple)
                    }
                }
                Text("for developers to complete a project for me")
                    .font(.caption)
                    .frame(width: 120)

            }
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
        }
        

    }
    
    var projectInfo: some View {
        VStack(alignment: .leading){
            Text("Project Title")
                .font(.headline)
            CustomInputField(imageName: "quote.bubble",
                             placeholderText: "",
                             text: $projectTitle)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            
            Text("Overview")
                .font(.headline)
            
            TextArea("", text: $overview, "quote.bubble")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            
            Text("Details")
                .font(.headline)
            
            TextArea("", text: $details, "square.and.pencil")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            
            Text("Tags")
                .font(.headline)
            
            AddSkillsView(placeholder: "", skillsList: $tags)

        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))

    }
    
    var projectInfo2: some View {
        VStack(alignment: .leading) {
            Text("School")
                .font(.headline)
            
            CustomInputField(imageName: "graduationcap",
                             placeholderText: "",
                             text: $school)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            
            Text("City")
                .font(.headline)
            
            CustomInputField(imageName: "building.2",
                             placeholderText: "",
                             text: $city)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
        }
    }
    
    var timeline: some View {
        VStack(alignment: .leading){
            
            Text("Timeline")
                .font(.headline)
            
            VStack {
                DatePicker("From", selection: $fromDate, displayedComponents: .date)
                    .font(.caption)
                DatePicker("To", selection: $toDate, displayedComponents: .date)
                    .font(.caption)
            }
        }
        
    }
    
    var membersNeeded: some View {
        HStack{
            
            Text("Members Needed:")
                .font(.headline)
            
            VStack {
                Picker("", selection:$minMembers){
                    ForEach(1...10, id: \.self){
                        Text("\($0)")
                    }
                }
                .padding()
            }
        }

    }
    
    var createButton: some View {
        HStack {
            Spacer()
            Button {
                viewModel.uploadProject(toDevelop: toDevelop, projectTitle: projectTitle, overview: overview, details: details, tags: tags, school: school, city: city, fromDate: fromDate, toDate: toDate, membersNeeded: minMembers)
                toDevelop = false
                forDevelopers = false
                projectTitle = ""
                overview = ""
                details = ""
                tags = []
                school = ""
                city = ""
                fromDate = Date.now
                toDate = Date.now
                minMembers = 1
                projectCreated.toggle()

            } label: {
                Text("Save Project")
                    .padding(8)
                    .font(.headline)
                    .foregroundColor(.black)
                    .background(Color.purple.opacity(0.5))
                    .cornerRadius(10)
                
            }
            .fullScreenCover(isPresented: $projectCreated){
                ProjectCreatedView()
            }
        }
    }
}
