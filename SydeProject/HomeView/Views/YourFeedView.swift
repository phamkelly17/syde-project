//
//  YourFeedView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI

struct YourFeedView: View {
    @ObservedObject var viewModel = HomeViewModel()
    let currentUser: User
    var body: some View {
        VStack{
            ScrollView{
                Text("")
                ProjectsScrollView(projects: viewModel.projects)
            }
        }
    }
}
