//
//  FriendsService.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-03-28.
//

import Firebase

struct FriendsService {
    
    func friendUser(_ profileUser: String, completion: @escaping() -> Void){
        guard let currentUser = Auth.auth().currentUser else { return }
        
        var friends: [String] = []
        Firestore.firestore().collection("users")
            .document(currentUser.uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                friends = user.friends
                friends.append(profileUser)
                
                Firestore.firestore().collection("users")
                    .document(currentUser.uid).updateData([
                        "friends": friends
                    ]) { _ in
                        completion()
                    }
            }
        
    }
    
    func unfriendUser(_ profileUser: String, completion: @escaping() -> Void){
        guard let currentUser = Auth.auth().currentUser else { return }

        var friends: [String] = []
        Firestore.firestore().collection("users")
            .document(currentUser.uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                friends = user.friends
                friends.removeAll(where: { $0 == profileUser })
                
                Firestore.firestore().collection("users")
                    .document(currentUser.uid).updateData([
                        "friends": friends
                    ]) { _ in
                        completion()
                    }
            }
    }
    
    func checkIfFriends(_ profileUser: String, completion: @escaping(Bool) -> Void){
        guard let currentUser = Auth.auth().currentUser else { return }
        
        Firestore.firestore().collection("users")
            .document(currentUser.uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                if user.friends.contains(where: {$0 == profileUser}) {
                    completion(true)
                }
                else{
                    completion(false)
                }
            }
    }
    
}
