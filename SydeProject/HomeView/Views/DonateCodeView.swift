//
//  DonateCodeView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-12.
//

import SwiftUI

struct DonateCodeView: View {
    @ObservedObject var viewModel = HomeSpecifiedViewModel(joinTeam: false)
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

struct DonateCodeView_Previews: PreviewProvider {
    static var previews: some View {
        DonateCodeView()
    }
}
