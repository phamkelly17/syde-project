//
//  MeView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-11.
//

import SwiftUI

struct MeView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showEditProfile = false
    @State private var showNotifications = false
    @State private var showLikes = false
    @State private var showBids = false
    @EnvironmentObject var authViewModel:AuthViewModel
        
    var user: User
    
    init (user: User){
        self.user = user
        self.viewModel = ProfileViewModel(user: self.user)
    }
    
    var body: some View {
        if let currentUser = viewModel.currentUser {
            VStack (alignment: .leading){
                
                HStack{
                    Image("logo-icon")
                        .resizable()
                        .frame(width:50, height:50)
                    Text("My Profile")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Button{
                                showNotifications.toggle()
                            } label: {
                                Image(systemName: "exclamationmark.bubble.fill")
                                if viewModel.notificationCount > 0 {
                                    Text("\(viewModel.notificationCount)")
                                }
                                
                            }
                            .fullScreenCover(isPresented: $showNotifications){
                                NotificationsView()
                            }
                            
                            Button{
                                showLikes.toggle()
                            } label: {
                                Image(systemName: "star.fill")
                            }
                            .fullScreenCover(isPresented: $showLikes){
                                LikesView(user: currentUser)
                            }
                            .padding(.horizontal,3)
                            
                            Button{
                                showBids.toggle()
                            } label: {
                                Image(systemName: "checkmark.seal.fill")
                            }
                            .fullScreenCover(isPresented: $showBids){
                                BidsView(user: currentUser)
                            }

                        }
                        .padding(.leading)
                        .foregroundColor(.black)

                    }
                    
                }
                .padding(.top)
                .padding(.horizontal)
                
                HStack {
                  Spacer()
                    Button {
                        authViewModel.signOut()
                    }label: {
                        Text("Logout")
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal)
                }


                ScrollView {
                    LazyVStack (alignment: .leading) {
                        ProfileHeaderView(fullname: currentUser.fullname, header: currentUser.header, profileImage: currentUser.profileImageUrl)
                        
                        Button{
                            showEditProfile.toggle()
                        } label: {
                            Text("Edit Profile")
                        }
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color.purple.opacity(0.5))
                        .cornerRadius(10)
                        .fullScreenCover(isPresented: $showEditProfile){
                            EditProfileView(name: currentUser.fullname, header: currentUser.header, about: currentUser.about, skillsList: currentUser.skills, interestsList: currentUser.interests, school: currentUser.school, city: currentUser.city, email: currentUser.email, linkedin: currentUser.linkedin, instagram: currentUser.instagram, profileImageURL: currentUser.profileImageUrl)
                        }
                        
                        CurrentProjectsView(projects: viewModel.projects)
                        AboutView(aboutText: currentUser.about, skillsList: currentUser.skills, interestsList: currentUser.interests, school: currentUser.school, city: currentUser.city, email: currentUser.email , linkedin: currentUser.linkedin, instagram: currentUser.instagram)
                    }
                }
                .padding(13)
                
               // }
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarHidden(true)
        }
    }
}
