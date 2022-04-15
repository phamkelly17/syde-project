//
//  UploadProjectViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-13.
//

import Foundation

class UploadProjectViewModel: ObservableObject {
    @Published var didUploadProject = false
    
    let service = ProjectService()
    
    func uploadProject(toDevelop: Bool, projectTitle: String, overview: String, details: String, tags: [String], school: String, city: String, fromDate: Date, toDate: Date, membersNeeded: Int){
        service.uploadProject(toDevelop: toDevelop, projectTitle: projectTitle, overview: overview, details: details, tags: tags, school: school, city: city, fromDate: fromDate, toDate: toDate, membersNeeded: membersNeeded){ success in
            if success {
                self.didUploadProject = true
            } else {
                
            }
        }
        
        
    }
}
