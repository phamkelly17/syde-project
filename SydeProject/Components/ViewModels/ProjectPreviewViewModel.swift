//
//  ProfilePreviewViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-20.
//

import Firebase

class ProjectPreviewViewModel: ObservableObject {
    
    private let service = ProjectService()
    @Published var project: Project
    
    init(project: Project){
        self.project = project
        self.checkIfUserLikeProject()
        self.checkIfUserBidProject()
    }
    
    func likeProject() {
        service.likeProject(project) {
            self.project.didLike = true
        }
    }
    
    func unlikeProject(){
        service.unlikeProject(project){
            self.project.didLike = false
        }
    }
    
    func checkIfUserLikeProject() {
        service.checkIfUserLikedProject(project) { didLike in
            if didLike {
                self.project.didLike = true
            }
        }
    }
    
    func bidProject(){
        let message = "bid on your project"
        service.createNotification(recipient: self.project.uid, message: message, projectTitle: self.project.projectTitle)
        service.bidProject(project) {
            self.project.didBid = true
        }
    }
    
    func unbidProject(){
        service.unbidProject(project) {
            self.project.didBid = false
        }
    }
    
    func checkIfUserBidProject() {
        service.checkIfUserBidProject(project) { didBid in
            if didBid {
                self.project.didBid = true
            }
        }
    }
    
}
