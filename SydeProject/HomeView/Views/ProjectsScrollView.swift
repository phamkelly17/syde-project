//
//  ProjectsScrollView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI

struct ProjectsScrollView: View {
    let projects: [Project]

    var body: some View {
        
        LazyVStack{
            Text("")
            ForEach(projects) { project in
                Text("")
                NavigationLink (destination: ProjectView(project: project)){
                    ProjectPreviewView(project: project)
                }
            }
        }
    }
}
