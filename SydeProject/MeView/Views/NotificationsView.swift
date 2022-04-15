//
//  NotificationsView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-15.
//

import SwiftUI
import Kingfisher

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = NotificationsViewModel()
    @State private var showProfile = false
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                Button {
                    viewModel.readNotifications()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrowtriangle.backward.fill")
                        .foregroundColor(.black)
                }
                .padding()
                
                Text("Notifications")
                    .font(.title)
            }
            .frame(height: 30)
            .padding(.vertical)
            
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.notifications){ notification in
                        HStack(spacing: 20) {

                            if let user = notification.user {
                                
                                Button{
                                    showProfile.toggle()
                                } label: {
                                    HStack {
                                        KFImage(URL(string: user.profileImageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width:75, height: 75)
                                            .cornerRadius(15)
                                            .padding(.leading, 10)
                                            .padding(.trailing, 10)
                                        
                                        VStack(alignment: .leading){
                                        Text(user.fullname).fontWeight(.bold) + Text(" \(notification.message), ") + Text(notification.projectTitle).fontWeight(.bold).foregroundColor(.purple)
                                        }
                                        .padding()
                                    }
                                    .padding()
                                    .background(notification.isRead ? Color.white : Color.purple.opacity(0.2))
                                    .cornerRadius(15)
                                }
                                .fullScreenCover(isPresented: $showProfile){
                                    FriendProfileView(profileUser: user)
                                }
                                

                            }

                        }
                        .padding(10)

                    }
                }
            }


        }
        
    }
}
