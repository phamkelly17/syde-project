//
//  BiddersViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-25.
//

import Foundation

class BiddersViewModel: ObservableObject {
    let project: Project
    private let service = UserService()
    private let projectService = ProjectService()

    @Published var bidders = [User]()
    @Published var members = [User]()
    @Published var showBiddersList = [Bool]()
    @Published var biddersCount = Int()
    
    init(project: Project){
        self.biddersCount = 0
        self.project = project
        self.fetchBidders()
        self.fetchMembers()
        self.fetchShowBiddersList()
    }
    
    func fetchBidders(){
        for userUid in project.bidders {
            service.fetchUser(withUid: userUid){ user in
                self.bidders.append(user)
            }
            self.biddersCount += 1
        }

    }
    func addMember(_ uid: String){
        let message = "added you to their project"
        self.projectService.createNotification(recipient: uid, message: message, projectTitle: self.project.projectTitle)
        
        self.projectService.addMember(project, uid)
        
        service.fetchUser(withUid: uid) { user in
            self.members.append(user)

        }
        
    }

    
    func removeMember(_ uid: String){
        self.projectService.removeMember(project, uid)
        
        for i in 0 ..< project.bidders.count{
            print(project.bidders[i])
            if project.bidders[i] == uid {
                self.showBiddersList[i] = false
            }
        }
    }
    
    func fetchMembers(){
        self.members = []
        for userUid in project.members {
            service.fetchUser(withUid: userUid){ user in
                self.members.append(user)
            }
        }
    }
    
    func fetchShowBiddersList(){
        for bidder in project.bidders{
            showBiddersList.append(self.bidderIsMember(bidder))
        }
    }
    
    func bidderIsMember(_ uid: String) -> Bool{
        if project.members.contains(uid){
            return true
        }
        return false
    }
    
}
