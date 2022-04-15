//
//  NotificationsViewModel.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-31.
//

import Foundation

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    private let service = NotificationsService()
    private let userService = UserService()
    
    init(){
        self.fetchNotifications()
    }
    
    func fetchNotifications() {
        print("here")
        service.fetchNotifications(){ notifications in
            self.notifications = notifications
            
            for i in 0 ..< notifications.count {
                let uid = notifications[i].sender
                self.userService.fetchUser(withUid: uid) { user in
                    self.notifications[i].user = user
                }
            }
        }
    }
    
    func readNotifications() {
        service.readNotifications()
    }
}
