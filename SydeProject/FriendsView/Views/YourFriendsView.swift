//
//  YourFriendsView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-29.
//

import SwiftUI

struct YourFriendsView: View {
    @ObservedObject var viewModel: FriendsViewModel
    let currentUser: User
    
    init(currentUser: User){
        self.currentUser = currentUser
        self.viewModel = FriendsViewModel(self.currentUser)
        
    }
    var body: some View {
        SearchBar(text: $viewModel.searchText)
        
        ScrollView{
            LazyVStack{

                ForEach(viewModel.searchableFriends) { user in
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
