//
//  HomeSpecifiedViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-15.
//

import Foundation

class HomeSpecifiedViewModel: ObservableObject {
    @Published var projects = [Project]()
    let service = ProjectService()
    let userService = UserService()
    let joinTeam: Bool
    
    init(joinTeam: Bool) {
        self.joinTeam = joinTeam
        self.fetchProjects()
    }
    
    func fetchProjects() {
        service.fetchProjects(forOption: joinTeam) { projects in
            self.projects = projects
            
            for i in 0 ..< projects.count {

                let uid = projects[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.projects[i].user = user
                }
            }
        }
    }
}
