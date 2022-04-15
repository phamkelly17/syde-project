//
//  BiddersView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-25.
//

import SwiftUI

struct BiddersView: View {

    @ObservedObject var viewModel: BiddersViewModel
    let project: Project
    
    init(project: Project){
        self.project = project
        self.viewModel = BiddersViewModel(project: project)
    }

    var body: some View {
        VStack(alignment: .leading){
            PageHeaderView(title:"Project Bidders")
                .padding(.vertical)
            ScrollView{
                LazyVStack{
                    ForEach(0 ..< viewModel.biddersCount){ i in
                        HStack(){
                            NavigationLink {
                                FriendProfileView(profileUser:viewModel.bidders[i])
                            } label: {
                                FriendRowView(user: viewModel.bidders[i])
                            }
                            Spacer()
                            if let uid = viewModel.bidders[i].id {
                                if viewModel.bidderIsMember(uid) {
                                    Text("Added to Project")
                                        .padding(8)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                        .background(Color.purple.opacity(0.2))
                                        .cornerRadius(10)
                                }
                                else {
                                    Button{
                                        viewModel.addMember(uid)
                                        viewModel.members.append(viewModel.bidders[i])

                                        viewModel.showBiddersList[i].toggle()
                                        viewModel.fetchMembers()
                                        viewModel.bidderIsMember(uid)
                                    } label: {
                                        Text("Add to Project")
                                            .padding(8)
                                            .font(.caption)
                                            .foregroundColor(.black)
                                            .background(Color.purple.opacity(0.5))
                                            .cornerRadius(10)
                                    }
                                }
                            }
                            


                        }
                        
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Bidders")
        .navigationBarHidden(true)
    }
}
