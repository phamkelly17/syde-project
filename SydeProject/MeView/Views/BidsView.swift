//
//  BidsView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-25.
//

import SwiftUI

struct BidsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User){
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            PageHeaderView(title:"Bidded Projects")
                .padding(.vertical)
            ScrollView{
                ProjectsScrollView(projects: viewModel.bidProjects)
            }
        }
        .padding()
    }
}
