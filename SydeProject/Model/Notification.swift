//
//  Notification.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-31.
//

import FirebaseFirestoreSwift
import Firebase

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    let recipient: String
    let sender: String
    let message: String
    let projectTitle: String
    let isRead: Bool
    var user: User?
    let timestamp: Timestamp
}
