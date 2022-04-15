//
//  SearchView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-29.
//

import SwiftUI

struct SearchView: View {
    let currentUser: User
    @ObservedObject var viewModel: FriendsViewModel
    
    init(currentUser: User){
        self.currentUser = currentUser
        self.viewModel = FriendsViewModel(currentUser)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            SearchBar(text: $viewModel.searchText)
            
            ScrollView{
                LazyVStack{
                    if viewModel.searchText == "" {
                        Text("")
                    }
                    else {
                        ForEach(viewModel.searchableUsers) { user in
                            NavigationLink {
                                FriendProfileView(profileUser:user)
                            } label: {
                                FriendRowView(user: user)
                            }
                        }
                    }
                }
            }
        }
    }
}
