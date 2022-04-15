//
//  NotificationsService.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-31.
//

import Firebase

struct NotificationsService {
    func fetchNotifications(completion: @escaping([Notification]) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("notifications")
            .whereField("recipient", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let notifications = documents.compactMap( { try? $0.data(as: Notification.self) })
                print(notifications)
                completion(notifications.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func readNotifications() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("notifications")
            .whereField("recipient", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let notifications = documents.compactMap( { try? $0.data(as: Notification.self) })
                
                for notification in notifications {
                    guard let notifId = notification.id else { return }
                    
                    Firestore.firestore().collection("notifications").document(notifId)
                        .updateData(["isRead": true])
                }
            }
    }
    
    func getNumUnread(completion: @escaping(Int) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("notifications")
            .whereField("recipient", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let notifications = documents.compactMap( { try? $0.data(as: Notification.self) })
                var unreadCount = 0
                for notification in notifications {
                    if !notification.isRead {
                        unreadCount += 1
                    }
                }
                completion(unreadCount)
            }
        
    }
}
