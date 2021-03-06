//
//  Project.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-15.
//

import FirebaseFirestoreSwift
import Firebase

struct Project: Identifiable, Decodable {
    @DocumentID var id: String?
    let uid: String
    let toDevelop: Bool
    let projectTitle: String
    let overview: String
    let details: String
    let tags: [String]
    let school: String
    let city: String
    let fromDate: Date
    let toDate: Date
    let membersNeeded: Int
    let timestamp: Timestamp
    let bidders: [String]
    var likes: Int
    var bids: Int
    var user: User?
    var didLike: Bool? = false
    var didBid: Bool? = false
    var members: [String]
}
