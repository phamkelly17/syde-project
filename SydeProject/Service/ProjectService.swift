//
//  ProjectService.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-13.
//

import Firebase

struct ProjectService {
    
    func uploadProject (toDevelop: Bool, projectTitle: String, overview: String, details: String, tags: [String], school: String, city: String, fromDate: Date, toDate: Date, membersNeeded: Int, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "likes": 0,
                    "bids": 0,
                    "bidders":[],
                    "members":[],
                    "toDevelop": toDevelop,
                    "projectTitle": projectTitle,
                    "overview": overview,
                    "details": details,
                    "tags": tags,
                    "school": school,
                    "city": city,
                    "fromDate": fromDate,
                    "toDate": toDate,
                    "membersNeeded": membersNeeded,
                    "timestamp": Timestamp(date:Date())] as [String: Any]

        
        Firestore.firestore().collection("projects").document()
            .setData(data) { error in
                if let error =  error {
                    print("DEBUG: failed to upload project with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    func createNotification(recipient: String, message: String, projectTitle: String) {
        guard let sender = Auth.auth().currentUser?.uid else { return }
        
        let data = ["recipient": recipient,
                    "sender": sender,
                    "message": message,
                    "projectTitle": projectTitle,
                    "timestamp": Timestamp(date:Date()),
                    "isRead": false] as [String: Any]
        
        Firestore.firestore().collection("notifications").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: failed to upload notification with error: \(error.localizedDescription)")
                    //completion(false)
                    return
                }
                //completion(true)
            }
    }
    
    func fetchProjects(completion: @escaping([Project]) -> Void) {
        Firestore.firestore().collection("projects")
            .order(by:"timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let projects = documents.compactMap ( { try? $0.data(as: Project.self) } )
                completion(projects)
            }
    }
    
    
    func fetchProjects(forOption toDevelop: Bool, completion: @escaping([Project]) -> Void ) {
        if toDevelop {
            Firestore.firestore().collection("projects")
                .whereField("toDevelop", isEqualTo: true)
                .getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    
                    let projects = documents.compactMap( { try? $0.data(as: Project.self) })
                    completion(projects.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() } ))
                }
        }
        else {
            Firestore.firestore().collection("projects")
                .whereField("toDevelop", isEqualTo: false)
                .getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    
                    let projects = documents.compactMap( { try? $0.data(as: Project.self) })
                    completion(projects.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() } ))
                    //completion(projects.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                }
        }
    }
    
    func fetchProjects(forUid uid: String, completion: @escaping([Project]) -> Void) {
        Firestore.firestore().collection("projects")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let projects = documents.compactMap( { try? $0.data(as: Project.self) })
                completion(projects.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func actionAdd (_ project: Project, _ uid: String, _ collectionName: String, _ collectionContents: String, _ collectionContentsNum: Int, completion: @escaping() -> Void) {
            guard let projectId = project.id else { return }
        
            let userLikesRef = Firestore.firestore().collection("users")
                .document(uid).collection(collectionName)
        
            Firestore.firestore().collection("projects").document(projectId)
                .updateData([
                    collectionContents: collectionContentsNum + 1]
                ) { _ in
                    userLikesRef.document(projectId).setData([:]) { _ in
                        completion()
                    }
                }
        
    }
    
    func actionDelete (_ project: Project, _ uid: String, _ collectionName: String, _ collectionContents: String, _ collectionContentsNum: Int, completion: @escaping() -> Void) {
        
        guard let projectId = project.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users")
            .document(uid).collection(collectionName)
        
        Firestore.firestore().collection("projects").document(projectId)
            .updateData([collectionContents: collectionContentsNum - 1]) { _ in
                userLikesRef.document(projectId).delete { _ in
                    completion()
                }
            }
        
    }
    
    func likeProject(_ project: Project, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        self.actionAdd(project, uid, "user-likes", "likes", project.likes) {
            completion()
        }
    }
    
    func unlikeProject (_ project: Project, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        self.actionDelete(project, uid, "user-likes", "likes", project.likes){
            completion()
        }
    }
    
    func bidProject(_ project: Project, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let projectId = project.id else { return }
        var bidders: [String] = project.bidders
        
        bidders.append(uid)
        
        Firestore.firestore().collection("projects").document(projectId).updateData([
            "bidders": bidders
        ]){ _ in

        }
        self.actionAdd(project, uid, "user-bids", "bids", project.bids) {
            completion()
        }
    }
    
    func unbidProject(_ project: Project, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let projectId = project.id else { return }
        var bidders: [String] = project.bidders
        
        bidders.removeAll(where: { $0 == uid })
        
        Firestore.firestore().collection("projects").document(projectId).updateData([
            "bidders": bidders
        ]){ _ in

        }
        self.actionDelete(project, uid, "user-bids", "bids", project.bids){
            completion()
        }
    }
    
    func checkAction(_ project: Project, _ collectionName: String, completion: @escaping(Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let projectId = project.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection(collectionName)
            .document(projectId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func checkIfUserLikedProject(_ project: Project, completion: @escaping(Bool) -> Void) {
        self.checkAction(project, "user-likes"){ result in
            completion(result)
        }
    }
    
    func checkIfUserBidProject(_ project: Project, completion: @escaping(Bool) -> Void) {
        self.checkAction(project, "user-bids"){ result in
            completion(result)
        }
    }

    func fetchSpecifiedProjects(forUid uid: String, collectionName: String, completion: @escaping([Project]) -> Void) {
        var projects = [Project]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection(collectionName)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let projectID = doc.documentID
                    
                    Firestore.firestore().collection("projects")
                        .document(projectID)
                        .getDocument{ snapshot, _ in
                            guard let project = try? snapshot?.data(as: Project.self) else { return }
                            projects.append(project)
                            
                            completion(projects)
                        }
                }
            }
    }
    
    func addMember(_ project: Project, _ uid: String) {
        guard let projectId = project.id else { return }
        var members: [String] = []
        
        Firestore.firestore().collection("projects")
            .document(projectId)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let project = try? snapshot.data(as: Project.self) else { return }
                
                members = project.members
                members.append(uid)
                
                Firestore.firestore().collection("projects")
                    .document(projectId).updateData([
                        "members": members
                    ])
            }
    }
    
    func removeMember(_ project: Project, _ uid: String){
        guard let projectId = project.id else { return }
        var members: [String] = []
        
        Firestore.firestore().collection("projects")
            .document(projectId)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let project = try? snapshot.data(as: Project.self) else { return }
                
                members = project.members
                members.removeAll(where: { $0 == uid })
                
                Firestore.firestore().collection("projects")
                    .document(projectId).updateData([
                        "members": members
                    ])
            }
    }
}
