//
//  ProjectMembersView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-25.
//

import SwiftUI

struct ProjectMembersView: View {
    @ObservedObject var viewModel: BiddersViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    let project: Project
    
    init(project: Project){
        self.project = project
        self.viewModel = BiddersViewModel(project: project)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            PageHeaderView(title:"Project Members")
                .padding(.vertical)
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.members) { member in
                        HStack(){
                            NavigationLink {
                                FriendProfileView(profileUser: member)
                            } label: {
                                FriendRowView(user: member)
                            }
                            Spacer()
                            if viewModel.project.user == authViewModel.currentUser{
                                Button{
                                    if let uid = member.id {
                                        viewModel.removeMember(uid)
                                        for i in (0 ..< viewModel.members.count) {
                                            print("i = \(i)")
                                            if viewModel.members[i].id == uid {
                                                viewModel.members.remove(at: i)
                                            }
                                        }
                                        
                                    }
                                } label: {
                                    Text("Remove")
                                        .padding(8)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                        .background(Color.purple.opacity(0.5))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Members")
        .navigationBarHidden(true)
    }
}
