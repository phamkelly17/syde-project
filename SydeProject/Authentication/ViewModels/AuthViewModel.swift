//
//  AuthViewMode.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-02-23.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var invalidEmail = false
    @Published var inUse = false
    @Published var currentUser: User?
    @Published var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password:String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    let err = error as NSError
                    
                    switch err.code {
                    case AuthErrorCode.wrongPassword.rawValue:
                        print("wrong password or email")
                    default:
                        print("default")
                    }
                    return
                }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
                
        }
    }
    
    func register(withEmail email:String, password:String, username: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                let err = error as NSError
                
                switch err.code {
                case AuthErrorCode.invalidEmail.rawValue:
                    self.invalidEmail = true
                    print("invalid email")
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    self.inUse = true
                default:
                    print("default")
                }
                return
            }
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
            
            let data = ["email": email,
                        "username": username,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                }
        }
        
    }
    
    func signOut() {
        // shows the login page
        userSession = nil
        self.didAuthenticateUser = false
        // signs user out on backend
        try? Auth.auth().signOut()
    }
    

    
    func updateUserData (_ fullname: String, _ headerText: String, _ about: String, _ skills: [String], _ interests: [String], _ school: String, _ city: String, _ linkedin: String, _ instagram: String, _ currentUserSession: FirebaseAuth.User?, _ newUser: Bool) {
        
        guard let uid = currentUserSession?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).updateData([
            "fullname": fullname,
            "header" : headerText,
            "about" : about,
            "skills": skills,
            "interests": interests,
            "school": school,
            "city": city,
            "linkedin": linkedin,
            "instagram": instagram,
            "friends": []
            
        ]) { _ in
            if newUser {
                self.fetchRegisterData()
            }

        }
    }
    
    func uploadImage (_ image: UIImage, _ currentUserSession: FirebaseAuth.User?, _ newUser: Bool){
        
        guard let uid = currentUserSession?.uid else { return }

        ImageUploader.uploadImage(image:image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    if newUser {
                        self.fetchRegisterData()
                    }
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
    
    func fetchRegisterData () {
        self.userSession = self.tempUserSession
        self.fetchUser()
    }
        
}
