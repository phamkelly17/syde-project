//
//  HomeViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-15.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var projects = [Project]()
    @Published var userProjects = [Project]()
    let service = ProjectService()
    let userService = UserService()
    //let currentUser: User
    
    init() {
        //self.currentUser = currentUser
        self.fetchProjects()
    }
    
    func fetchProjects(){
        service.fetchProjects { projects in
            self.projects = projects
            print("count: \(self.projects.count)")
            
            for i in 0 ..< projects.count {
                let uid = projects[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.projects[i].user = user
                }
            }
        }
    }

    
}
