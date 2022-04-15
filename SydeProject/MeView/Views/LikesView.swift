//
//  LikesView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-21.
//

import SwiftUI

struct LikesView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User){
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            PageHeaderView(title:"Favourited Projects")
                .padding(.vertical)
            ScrollView{
                ProjectsScrollView(projects: viewModel.likedProjects)
            }
        }
        .padding()
    }
}
