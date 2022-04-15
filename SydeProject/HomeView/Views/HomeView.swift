//
//  HomeView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-11.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedFilter: HomeFilterViewModel = .yourFeed
    @Namespace var animation
    
    let currentUser: User
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("logo-icon")
                    .resizable()
                    .frame(width:50, height: 50)
                
                //try this with bid view + memberrs!!!!!
                //add memvers icon under checkmark
                ForEach(HomeFilterViewModel.allCases, id: \.rawValue) {item in
                    VStack {
                        Text(item.title)
                            .font(.subheadline)
                        
                        if selectedFilter == item {
                            Capsule()
                                .foregroundColor(Color(.purple))
                                .frame(height:3)
                                .matchedGeometryEffect(id: "filter", in: animation)
                        } else {
                            Capsule()
                                .foregroundColor(Color(.clear))
                                .frame(height: 3)
                        }
                        
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            self.selectedFilter = item
                        }
                    }

                }
            }
            if selectedFilter == .yourFeed {
                YourFeedView(currentUser: currentUser)

            }
            else if selectedFilter == .joinTeam{
                JoinTeamView()

            }
            else {
                DonateCodeView()

            }
        }
        .padding()
        .navigationTitle("jfjf")
        .navigationBarHidden(true)
    }
}
