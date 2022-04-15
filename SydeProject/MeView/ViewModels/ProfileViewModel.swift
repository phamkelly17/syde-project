//
//  ProfileViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-16.
//

import Foundation
//user should nbe published variable, need fetch user function!
class ProfileViewModel: ObservableObject {
    @Published var projects = [Project]()
    @Published var likedProjects = [Project]()
    @Published var bidProjects = [Project]()
    @Published var notificationCount = Int()
    @Published var currentUser: User?
    private let userService = UserService()
    private let service = ProjectService()
    private let notificationsService = NotificationsService()
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUser()
        self.fetchUserProjects()
        self.fetchLikedProjects()
        self.fetchBidProjects()
        self.getNotificationsCount()
    }
    
    func fetchUser(){
        guard let uid = user.id else { return }
        
        userService.fetchUser(withUid: uid) { currentUser in
            self.currentUser = currentUser
        }
    }
    
    func fetchUserProjects() {
        guard let uid = user.id else { return }
        service.fetchProjects(forUid: uid){ projects in
            self.projects = projects
            
            for i in 0 ..< projects.count {
                let uid = projects[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.projects[i].user = user
                }
            }
        }
    }
    
    func fetchLikedProjects() {
        guard let uid = user.id else { return }
        service.fetchSpecifiedProjects(forUid: uid, collectionName: "user-likes") { projects in
            self.likedProjects = projects
            
            for i in 0 ..< projects.count {
                let uid = projects[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedProjects[i].user = user
                    
                }
            }
        }
    }
    
    func fetchBidProjects() {
        guard let uid = user.id else { return }
        service.fetchSpecifiedProjects(forUid: uid, collectionName: "user-bids") { projects in
            self.bidProjects = projects
            
            for i in 0 ..< projects.count {
                let uid = projects[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.bidProjects[i].user = user
                    
                }
            }
        }
    }
    
    func getNotificationsCount() {
        notificationsService.getNumUnread(){ num in
            self.notificationCount = num
        }
    }

}
