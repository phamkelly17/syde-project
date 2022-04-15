//
//  FriendsView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-11.
//

import SwiftUI

struct FriendsView: View {
    @State private var selectedFilter: FriendsFilterViewModel = .friends
    @Namespace var animation
    @ObservedObject var viewModel: FriendsViewModel
    let currentUser: User

    init (currentUser: User){
        self.currentUser = currentUser
        self.viewModel = FriendsViewModel(self.currentUser)
    }
    
    var body: some View {
        VStack(alignment: .leading) {

            HStack {
                Spacer()
                Image("logo-icon")
                    .resizable()
                    .frame(width:50, height: 50)
                
                //try this with bid view + memberrs!!!!!
                //add memvers icon under checkmark
                ForEach(FriendsFilterViewModel.allCases, id: \.rawValue) {item in
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
            if selectedFilter == .friends {
                YourFriendsView(currentUser: currentUser)
            }
            else {
                SearchView(currentUser: currentUser)
            }
        }
        .padding()
        .navigationTitle("Network")
        .navigationBarHidden(true)
    }
}
