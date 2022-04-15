//
//  ContentView.swift
//  SydeProjectApp_3.0
//
//  Created by Kelly Pham on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
          //RegistrationView()
            
            if viewModel.userSession == nil{
                //no logged in user
                RegistrationView()
                    .navigationTitle("")
                    .navigationBarHidden(true)
            }
            else {
                //logged in user
                BottomBarView()
                    .navigationTitle("")
                    .navigationBarHidden(true)
            }
             
             
             
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
