//
//  FriendsViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-04.
//

import Foundation

class FriendsViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    @Published var friends = [User]()

    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter ({
                $0.username.contains(lowercasedQuery) ||
                $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    var searchableFriends: [User] {
        if searchText.isEmpty {
            return self.friends
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return friends.filter ({
                $0.username.contains(lowercasedQuery) ||
                $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    let currentUser: User
    let service = UserService()
    let friendService = FriendsService()
    
    init(_ currentUser: User) {
        self.currentUser = currentUser
        fetchUsers()
        fetchFriends()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
    }
    
    func fetchFriends() {
        self.friends = []
        for userUid in self.currentUser.friends{
            service.fetchUser(withUid: userUid) { user in
                self.friends.append(user)
            }
        }
    }
    

}
