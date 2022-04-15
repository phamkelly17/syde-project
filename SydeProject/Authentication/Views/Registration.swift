//
//  RegistrationView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-22.
//

import SwiftUI

struct RegistrationView: View {

    @State private var showRegistrationInfoView = false
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPasswordsMatch = false
    @State private var showInvalidUserName = false
    @EnvironmentObject var viewModel:AuthViewModel
    
    var body: some View {
            
        VStack (alignment: .leading){
            NavigationLink(destination: SecondInfoView(),
                           isActive: $viewModel.didAuthenticateUser,
                           label: { })
            Spacer()
            heading
            
            
            CustomInputField(imageName: "envelope",
                             placeholderText: "Email",
                            text: $email)
                .padding(.vertical)
            if viewModel.invalidEmail {
                Text("Invalid email.")
            }
            else if viewModel.inUse {
                Text("Email is already in use.")
            }
            usernameInput
            passwords
            
            HStack {
                Spacer()
                Button{
                    print(alphanumericsOnly(username))
                    if checkPasswordsMatch() && alphanumericsOnly(username){
                        viewModel.register(withEmail: email, password: password, username: username)
                    }
                    else {
                        if !alphanumericsOnly(username){
                            showInvalidUserName = true
                        }
                        else {
                            showInvalidUserName = false
                        }
                        
                        if !checkPasswordsMatch(){
                            showPasswordsMatch = true
                        }
                        else {
                            showPasswordsMatch = false
                        }
                    }
                } label: {
                    HStack {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .font(.title2)
                        Image(systemName:"arrow.right")

                    }
                    .foregroundColor(.black)
                    .padding(15)
                    .background(Color.purple.opacity(0.5))
                    .cornerRadius(10)
                }
            }
            .padding(.vertical,50)
            
            Spacer()
            
            HStack {
                Spacer()
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                    Text("Already have an account? Login!")
                        .foregroundColor(.purple)
                }

                Spacer()
            }
        }
        .padding()
        .navigationBarTitle("title")
        .navigationBarHidden(true)
    }

    func checkPasswordsMatch() -> Bool {
        if password == confirmPassword {
            return true
        }
        return false
    }
    
    //func isValidUsername(_ username: String) -> Bool {
    //    return username.range(of: "\\A\\w{7,18}\\z", options: .regularExpression) != nil
    //}
    func alphanumericsOnly(_ name: String, lengthRange: Range<Int> = 3..<19) -> Bool {
        guard  lengthRange ~= name.count , name.first!.isLetter else { return false }
        return name.allSatisfy{ $0.isLetter || $0.isNumber }
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}


extension RegistrationView {
    
    var usernameInput: some View {
        VStack(alignment: .leading) {
            CustomInputField(imageName: "person",
                             placeholderText: "Username",
                            text: $username)
                            .foregroundColor(.black)
                            .padding(.vertical)
            if showInvalidUserName {
                Text ("Username can only contain alphanumeric characters")
            }
        }
    }
    var passwords: some View {
        VStack(alignment: .leading){
            CustomInputField(imageName: "lock",
                             placeholderText: "Password",
                             isSecureField: true,
                            text: $password)
                            .padding(.vertical)
                            .foregroundColor(.black)
            
            CustomInputField(imageName: "lock",
                             placeholderText: "Confirm Password",
                             isSecureField: true,
                            text: $confirmPassword)
                            .foregroundColor(.black)
                            .padding(.vertical)
            if showPasswordsMatch {
                Text("Please check that your password match.")
            }
        }
    }
    var heading: some View {
        VStack(alignment: .leading){
            Image("logo-long")
                .resizable()
                .aspectRatio(contentMode:.fit)

            Text("Register")
                .font(.title)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
            
            Text("Create your account today to start creating projects with your friends!")
                .font(.title3)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
        }
    }
}
