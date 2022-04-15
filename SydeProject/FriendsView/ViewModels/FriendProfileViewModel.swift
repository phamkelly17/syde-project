//
//  FriendProfileViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-28.
//

import Firebase

class FriendProfileViewModel: ObservableObject {
    @Published var profileUser: User
    private let service = FriendsService()
    private let projectService = ProjectService()
    
    init(profileUser: User) {
        self.profileUser = profileUser
        self.checkIfFriends()
    }
    
    func friendUser(){        
        if let uid = self.profileUser.id {
            service.friendUser(uid){
                self.profileUser.didFriend = true
            }
            
            projectService.fetchProjects(forUid: uid){ projects in
                
            }
        }
    }
    
    func unfriendUser(){
        if let uid = self.profileUser.id {
            service.unfriendUser(uid) {
                self.profileUser.didFriend = false
            }
        }
    }
    
    func checkIfFriends(){
        if let uid = self.profileUser.id {
            service.checkIfFriends(uid) { isFriends in
                if isFriends{
                    self.profileUser.didFriend = true
                }
            }
        }
    }
}
