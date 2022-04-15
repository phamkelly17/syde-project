//
//  CurrentProjectsView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-15.
//

import SwiftUI

struct CurrentProjectsView: View {
    let projects: [Project]
    @State private var showEditProject = false
    @State private var currentProject = 0
    let numProjects: Int
    
    init(projects: [Project]){
        self.projects = projects
        self.numProjects = projects.count
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Current Projects")
                .font(.title2)
                .fontWeight(.bold)
            if self.numProjects > 0 {                    
                NavigationLink (destination: ProjectView(project: self.projects[currentProject])){
                    ProjectPreviewView(project: self.projects[currentProject])
                }
                .padding(.vertical,1)
                
                HStack {
                    Button {
                        if currentProject != 0 {
                            currentProject -= 1
                        } else {
                            currentProject = numProjects - 1
                        }
                    } label: {
                        Image(systemName:"arrowtriangle.backward.fill")
                    }
                    Spacer()
                    ForEach(0..<numProjects) { i in
                        if i == currentProject {
                            Image(systemName:"circle.fill")
                                .resizable()
                                .frame(width:10, height: 10)
                        } else {
                            Image(systemName:"circle")
                                .resizable()
                                .frame(width:10, height: 10)
                        }
                    }
                    Spacer()
                    Button {
                        if currentProject != (numProjects - 1) {
                            currentProject += 1
                        } else {
                            currentProject = 0
                        }
                    } label: {
                        Image(systemName:"arrowtriangle.forward.fill")
                    }
                }
                .foregroundColor(.purple.opacity(0.5))
                
            } else {
                Text("No projects yet.")
                    .padding(.vertical,1)
            }
        }
        .padding(.vertical)
        
    }
}
