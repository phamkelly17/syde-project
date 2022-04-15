//
//  BottomBarView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-11.
//
import SwiftUI

struct BottomBarView: View {
    @State private var selectedIndex = 0
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
        if let user = authViewModel.currentUser {
            TabView(selection: $selectedIndex) {
                HomeView(currentUser: user)
                    .onTapGesture {
                        self.selectedIndex = 0
                    }
                    .tabItem {
                        if (self.selectedIndex == 0) {
                            Image("home-icon-purple")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                        else{
                            Image("home-icon")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                    }.tag(0)
                    .background(Color.white)
     
                NewProjectView()
                    .onTapGesture {
                        self.selectedIndex = 1
                    }
                    .tabItem {
                        if (self.selectedIndex == 1) {
                            Image("new-project-icon-purple")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                        else{
                            Image("new-project-icon")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                    }
                    .tag(1)
                    .background(Color.white)
                
                FriendsView(currentUser: user)
                    .onTapGesture {
                        self.selectedIndex = 2
                    }
                    .tabItem {
                        if (self.selectedIndex == 2) {
                            Image("friends-icon-purple")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                        else{
                            Image("friends-icon")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                    }
                    .tag(2)
                    .background(Color.white)
                
                MeView(user: user)
                    .onTapGesture {
                        self.selectedIndex = 3
                    }
                    .tabItem {
                        if (self.selectedIndex == 3) {
                            Image("me-icon-purple")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                        else{
                            Image("me-icon")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
     
                    }
                    .tag(3)
                    .background(Color.white)
            }
            .background(Color.white)
        }

    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
    }
}
