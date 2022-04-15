//
//  FriendProfileView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-14.
//

import SwiftUI

struct FriendProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var friendsViewModel: FriendProfileViewModel
    @ObservedObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var mode
    @State private var friended = false
    let profileUser: User
    
    init(profileUser: User) {
        self.profileUser = profileUser
        self.viewModel = ProfileViewModel(user: self.profileUser)
        self.authViewModel = AuthViewModel()
        
        self.friendsViewModel = FriendProfileViewModel(profileUser: self.profileUser)

    }
    
    var body: some View {
        VStack (alignment: .leading){
            PageHeaderView(title: viewModel.user.username)
                .padding(.vertical)
            
            ScrollView{
                LazyVStack (alignment: .leading){
                    ProfileHeaderView(fullname: viewModel.user.fullname, header: viewModel.user.header, profileImage: viewModel.user.profileImageUrl)
                    friendButton
                    CurrentProjectsView(projects: viewModel.projects)
                    AboutView(aboutText: viewModel.user.about, skillsList: viewModel.user.skills, interestsList: viewModel.user.interests, school: viewModel.user.school , city: viewModel.user.city,email: viewModel.user.email,linkedin: viewModel.user.linkedin ,instagram: viewModel.user.instagram)
                }
            }
            .padding(13)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        
    }
}


extension FriendProfileView {

    
    var friendButton: some View {

        Button{
            friendsViewModel.profileUser.didFriend ?? false ? friendsViewModel.unfriendUser() : friendsViewModel.friendUser()
        } label: {
            friendsViewModel.profileUser.didFriend ?? false ? Text ("Unfollow") : Text ("Follow")
        }
        .foregroundColor(.black)
        .padding(8)
        .background(Color.purple.opacity(0.5))
        .cornerRadius(10)

    }


}
