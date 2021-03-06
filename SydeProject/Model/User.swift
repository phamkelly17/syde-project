//
//  User.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-03.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable, Equatable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    let header: String
    let about: String
    let skills: [String]
    let interests: [String]
    let school: String
    let city: String
    let linkedin: String
    let instagram: String
    var friends: [String]
    var didFriend: Bool? = false
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
    
}
