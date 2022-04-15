//
//  JoinCodeView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI

struct JoinTeamView: View {
    @ObservedObject var viewModel = HomeSpecifiedViewModel(joinTeam: true)
    var body: some View {
        VStack (alignment: .leading) {
            ScrollView {
                LazyVStack (alignment: .leading){
                    ProjectsScrollView(projects: viewModel.projects)
                }
            }

        }
    }
}
