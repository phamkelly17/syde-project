//
//  ProjectPreviewView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI

struct ProjectPreviewView: View {
    @ObservedObject var viewModel: ProjectPreviewViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    init(project: Project){
        self.viewModel = ProjectPreviewViewModel(project: project)
    }
    
    var body: some View {
        if let user = viewModel.project.user {
            VStack (alignment: .leading){
                if viewModel.project.toDevelop {
                    Text("\(user.fullname) is proposing...")
                        .font(.headline)
                } else {
                    Text("\(user.fullname) is looking for...")
                        .font(.headline)
                }

                projectBoxView

            }
            .foregroundColor(.black)

        }

    }
}


extension ProjectPreviewView {
    
    var projectBoxView: some View {
        
        VStack (alignment: .leading){
            
            HStack {
                Text (viewModel.project.projectTitle)
                    .foregroundColor(.black)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Button {
                    viewModel.project.didLike ?? false ? viewModel.unlikeProject() : viewModel.likeProject()
                } label: {
                    Image(systemName: viewModel.project.didLike ?? false ? "star.fill" : "star")
                        .foregroundColor(.purple)
                }
                
                if viewModel.project.user == authViewModel.currentUser{
                    NavigationLink {
                        BiddersView(project: viewModel.project)
                    } label: {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.purple)
                    }
                    
                } else {
                    Button {
                        viewModel.project.didBid ?? false ? viewModel.unbidProject() : viewModel.bidProject()
                    } label: {
                        Image(systemName: viewModel.project.didBid ?? false ? "checkmark.seal.fill" : "checkmark.seal")
                            .foregroundColor(.purple)
                        
                    }
                }

            }
            .padding()
            
            HStack {
                TagsView(items: viewModel.project.tags)
                    .padding(.horizontal)
                
                Spacer()
            }
            
            Text(viewModel.project.overview)
                .padding()
                .multilineTextAlignment(.leading)
                .font(.subheadline)
            
        }
        .background(Color.purple.opacity(0.2))
        .cornerRadius(15)
        

    }
}
