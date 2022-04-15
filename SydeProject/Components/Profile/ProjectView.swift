//
//  ProjectView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI
import Kingfisher

struct ProjectView: View {
    
    @ObservedObject var viewModel: ProjectPreviewViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var showMembers = false
    
    init(project: Project){
        self.viewModel = ProjectPreviewViewModel(project: project)
    }

    
    var body: some View {
        
        VStack (alignment: .leading){
            PageHeaderView(title: viewModel.project.projectTitle)
                .padding(.vertical)
            
            ScrollView {
                LazyVStack (alignment: .leading){
                    userHeader
                        .padding(.vertical)
                    ConstantWrappedTags(tags: viewModel.project.tags)

                    Text("Overview").fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 5, trailing: 0))
                        .font(.title2)
                    Text(viewModel.project.overview)
                    
                    Text("Description").fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 5, trailing: 0))
                        .font(.title2)
                    Text(viewModel.project.details)
                    
                    Text("Additional").fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 5, trailing: 0))
                        .font(.title2)
                    
                    additional
                }

            }
            .padding()
        }
        .navigationTitle("Project")
        .navigationBarHidden(true)
        
    }
}


extension ProjectView {
    
    var userHeader: some View {
        
        HStack {
            if let user = viewModel.project.user {
                
                NavigationLink {
                    FriendProfileView(profileUser:user)
                } label: {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width:75, height: 75)
                        .cornerRadius(10)
                }
                
                VStack (alignment: .leading, spacing: 8){
                    //name and star
                    HStack {
                        Text(user.fullname)
                            .font(.headline)


                        Spacer()
                        
                        Button {
                            viewModel.project.didLike ?? false ? viewModel.unlikeProject() : viewModel.likeProject()
                        } label: {
                            Image(systemName: viewModel.project.didLike ?? false ? "star.fill" : "star")
                                .foregroundColor(.purple)
                                .padding(.horizontal)
                        }
                    }
                    

                    // status and bid
                    HStack {
                        Text(user.username)
                            .foregroundColor(.gray)

                        Spacer()
                        
                        if user == authViewModel.currentUser{
                            NavigationLink {
                                BiddersView(project: viewModel.project)
                            } label: {
                                Image(systemName: "checkmark.seal.fill")
                                    .padding(.horizontal)
                                    .foregroundColor(.purple)
                                
                            }
                        } else {
                            Button {
                                viewModel.project.didBid ?? false ? viewModel.unbidProject() : viewModel.bidProject()
                            } label: {
                                Image(systemName: viewModel.project.didBid ?? false ? "checkmark.seal.fill" : "checkmark.seal")
                                    .padding(.horizontal)
                                    .foregroundColor(.purple)
                                
                            }
                        }
                    }
                    
                    HStack {
                        if viewModel.project.toDevelop{
                            Image(systemName: "laptopcomputer")
                                .foregroundColor(.purple)
                            Text("Looking to develop")
                                .font(.caption)
                        }
                        else {
                            Image(systemName: "waveform.and.magnifyingglass")
                                .foregroundColor(.purple)
                            Text("Looking to developers")
                                .font(.caption)
                        }

                        
                        Spacer()
                        
                        NavigationLink {
                            ProjectMembersView(project: viewModel.project)
                        } label: {
                            Image(systemName: "person.2.fill")
                                .padding(.horizontal)
                                .foregroundColor(.purple)
                        }
                    }
                }
            }
            
        }
        
    }
    
    var additional: some View {
        VStack(alignment: .leading) {
            HStack {
                //Text(releaseDate, format: Date.FormatStyle().year().month().day().weekday().hour().minute().second().timeZone())
                Text("Timeline")
                    .font(.headline)
                Text("\(viewModel.project.fromDate, format: Date.FormatStyle().month().day().year()) - \(viewModel.project.toDate, format: Date.FormatStyle().month().day().year())")
                    .padding(5)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(5)
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            HStack {
                Text("Members Needed")
                    .font(.headline)
                Text(String(viewModel.project.membersNeeded))
                    .padding(5)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(5)
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            
            HStack {
                Text("School")
                    .font(.headline)
                Text(viewModel.project.school)
                    .padding(5)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(5)
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            
            HStack {
                Text("City")
                    .font(.headline)
                Text(viewModel.project.city)
                    .padding(5)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(5)
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        }
    }
    
}
